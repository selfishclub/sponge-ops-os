#!/usr/bin/env bash
# sponge-ops-os 정합성 검사. 실패하면 exit 1.
set -u
cd "$(dirname "$0")/.."
fail=0
say(){ echo "✗ $1"; fail=1; }

# 1. frontmatter · CHANGELOG
head -1 SKILL.md | grep -q '^---$' || say "SKILL.md frontmatter 없음"
grep -q '^name: sponge-ops-os$' SKILL.md || say "SKILL.md name 불일치"
grep -q '^description: .\{80,\}' SKILL.md || say "SKILL.md description 80자 미만"
grep -q '^license:' SKILL.md || say "SKILL.md license 없음"
grep -q '^version:' SKILL.md || say "SKILL.md version 없음"
ver=$(sed -n 's/^version: //p' SKILL.md | head -1)
grep -q "^## $ver " CHANGELOG.md || say "CHANGELOG.md 에 $ver 없음"

# 2. references · templates 필수 파일 + SKILL.md 언급
for f in 00-detect 10-interview 11-ops-catalog 12-scoring 13-latest 14-human-only 20-form-ladder 21-browser-agents 22-impl-recipes 30-revisit 40-pitfalls 50-handoff; do
  [ -f "references/$f.md" ] || say "references/$f.md 없음"
  grep -q "references/$f.md" SKILL.md || say "SKILL.md가 references/$f.md 를 언급하지 않음"
done
for f in 00-map v1-plan vN-plan log; do
  [ -f "templates/$f.md" ] || say "templates/$f.md 없음"
  grep -q "templates/$f.md" SKILL.md || say "SKILL.md가 templates/$f.md 를 언급하지 않음"
done

# 3. 템플릿 필수 표지 (state.sh 와 모드 ② 가 기대는 것)
for k in '| 일 |' '| 영역 |' '| 누가 |' '| 주기 |' '한 번(분)' '주당(분)' '줄이는(분)' '실수 위험' '사람만 하는 단계' '준비·승인' '준비 난이도' '자동화 경로' '| 점수 |' '| 출처 |' '## 3. 운영 지도' 'G5'; do
  grep -qF "$k" templates/00-map.md || say "00-map.md 에 '$k' 없음"
done
for k in '^status:' '^task:' '^cycle:' '^shipped_at:' '^baseline_min_per_week:' '^baseline_source:' '대체됨' '## 8\. 줄어드는 것' 'v2 깊게' 'v2 넓게' 'v3 연결' '멈추는 곳'; do
  grep -qE "$k" templates/v1-plan.md || say "v1-plan.md 에 '$k' 없음"
done
for k in '지난 버전이 줄인 것' '^direction:' '^from:' '^status:' '^task:' '^cycle:' '^shipped_at:' 'connect-plan.md'; do
  grep -qE "$k" templates/vN-plan.md || say "vN-plan.md 에 '$k' 없음"
done
for k in '| 날짜 |' '걸린 분' '안 씀' '준비물 틀림' '주간 합계' '사람만 몫'; do
  grep -qF "$k" templates/log.md || say "log.md 에 '$k' 없음"
done

# 4. 스크립트 · state.sh 동작
for s in check state; do [ -x "scripts/$s.sh" ] || say "scripts/$s.sh 없거나 실행 권한 없음"; done
bash -n scripts/state.sh || say "state.sh 문법 오류"
t=$(mktemp -d)
mkdir -p "$t/empty"
bash scripts/state.sh "$t/empty" | grep -q '추천: ① 처음' || say "state.sh: 빈 폴더에서 ① 처음을 추천하지 않음"
mkdir -p "$t/club/1_mission/a/landing" "$t/club/3_session_skills"
touch "$t/club/1_mission/a/landing/package.json"
bash scripts/state.sh "$t/club" | grep -q '프로젝트 경로 필요' || say "state.sh: 스폰지클럽 저장소 판별 실패"
if command -v git >/dev/null; then
  git -C "$t/club" init -q
  bash scripts/state.sh "$t/club/1_mission/a/landing" | grep -q '프로젝트 경로 필요' || say "state.sh: 스폰지클럽 저장소 안의 하위 폴더를 막지 못함"
fi
ago(){ date -v-"$1"d +%F 2>/dev/null || date -d "$1 days ago" +%F; }
mkdir -p "$t/early/docs/ops-os"
printf '## 3. 운영 지도\n| 1 | a |\n' > "$t/early/docs/ops-os/00-map.md"
printf -- '---\nversion: v1\nstatus: 운영중\ntask: "#1"\nshipped_at: %s\n---\n' "$(ago 8)" > "$t/early/docs/ops-os/v1-plan.md"
printf '| 날짜 |\n| %s | v1 |\n' "$(ago 3)" > "$t/early/docs/ops-os/log.md"
bash scripts/state.sh "$t/early" | grep -q '추천: 아직 이르다' || say "state.sh: 8일째 log 1줄에서 아직 이르다가 아님"
rm -rf "$t"

# 5. 개인·브랜드·크루 식별 문자열
BAN='vetd|first100|G-SJH91732LJ|tvrmejtgyjxmklytuzmb|zemma|spongeclub-3|1_mission/[0-9]조'
if grep -rniE "$BAN" SKILL.md references templates CHANGELOG.md scripts/state.sh >/dev/null; then
  grep -rniE "$BAN" SKILL.md references templates CHANGELOG.md scripts/state.sh | head -5
  say "금지 문자열 발견 (위)"
fi
grep -niE "$BAN" README.md | grep -v '출처' >/dev/null && say "README.md 금지 문자열 (출처 줄 외)"

# 6. 실제 키 모양 값
if grep -rnE 'eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}|sk_(live|test)_[A-Za-z0-9]{10,}|AIza[0-9A-Za-z_-]{30,}|sb_secret_[A-Za-z0-9_-]{10,}|ghp_[A-Za-z0-9]{20,}' . --include='*.md' --include='*.sh' | grep -v '^\./scripts/check.sh:' >/dev/null; then
  say "키처럼 보이는 문자열 발견"
fi

# 7. SKILL.md 길이
lines=$(wc -l < SKILL.md); [ "$lines" -le 360 ] || say "SKILL.md ${lines}줄 (360 초과)"

# 8. 플레이스홀더 · 현황 파일 기준일
grep -rnE 'TBD|TODO|작성 중' SKILL.md references templates README.md >/dev/null && say "플레이스홀더(TBD/TODO/작성 중) 남음"
grep -qE '^\*\*기준일: 20[0-9]{2}-[0-9]{2}-[0-9]{2}\.\*\*' references/13-latest.md || say "13-latest.md 기준일 형식"

# 9. 교차 일관성
for tag in '[인증]' '[서명]' '[송금]' '[게시·발송]' '[제출·신고]'; do
  for f in SKILL.md references/12-scoring.md references/14-human-only.md references/21-browser-agents.md; do
    grep -qF "$tag" "$f" || say "$f 에 $tag 없음"
  done
done
for g in G1 G2 G3 G4 G5; do grep -q "$g" references/12-scoring.md || say "12-scoring.md 에 게이트 $g 없음"; done
grep -q '위험 우선' references/10-interview.md || say "10-interview.md S6 에 위험 우선 없음"
grep -q '대체됨' references/30-revisit.md || say "30-revisit.md 에 대체됨 없음"
for s in sponge-security-check sponge-admin-kit oneday-prd; do
  grep -q "^description:.*$s" SKILL.md || say "description 에 $s 없음"
done
grep -q 'github.com/selfishclub/sponge-ops-os' README.md || say "README.md 에 저장소 주소 없음"
for id in $(grep -rhoE 'L-[A-F][0-9]+' SKILL.md references templates --exclude=13-latest.md | sort -u); do
  grep -qE "^\| $id \|" references/13-latest.md || say "13-latest.md 에 $id 정의 없음"
done

[ $fail -eq 0 ] && echo "✓ check passed"
exit $fail
