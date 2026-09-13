#!/usr/bin/env bash
# sponge-ops-os 상태 파악 — 읽기 전용. 아무것도 쓰지 않는다.
# 사용: bash state.sh [프로젝트 경로]
set -u
P="${1:-.}"
if ! cd "$P" 2>/dev/null; then echo "✗ 경로 없음: $P"; exit 1; fi
D="docs/ops-os"

is_club(){ [ -d "$1/1_mission" ] && [ -d "$1/3_session_skills" ]; }
top=$(git rev-parse --show-toplevel 2>/dev/null || true)
if is_club . || { [ -n "$top" ] && is_club "$top"; }; then ctx="스폰지클럽 저장소"
elif [ -f package.json ] || [ -f pyproject.toml ] || [ -f requirements.txt ] || [ -f index.html ] || [ -f go.mod ] || [ -f Gemfile ]; then ctx="코드 저장소"
else ctx="코드 없음"; fi

# YYYY-MM-DD → 오늘까지 일수. 형식이 아니면 빈 값.
days_since(){
  local d="$1" s
  case "$d" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;; *) echo ""; return ;; esac
  s=$(date -j -f %Y-%m-%d "$d" +%s 2>/dev/null || date -d "$d" +%s 2>/dev/null) || { echo ""; return; }
  echo $(( ( $(date +%s) - s ) / 86400 ))
}
# frontmatter 한 줄 값 (주석·따옴표 제거)
fm(){ sed -n "s/^$2:[[:space:]]*//p" "$1" | head -1 | sed 's/[[:space:]]*#.*$//; s/^"//; s/"$//'; }

map_rows=0; plans=""; n_run=0; n_build=0; n_plan=0; run_tasks=""; latest_ship=""
log_rows=0; recent_logs=0; last_log=""
if [ -f "$D/00-map.md" ]; then
  map_rows=$(awk '/^## 3\./{f=1;next} /^## /{f=0} f && /^\| *[0-9]+ *\|/{c++} END{print c+0}' "$D/00-map.md")
fi
for f in "$D"/v*-plan.md "$D"/connect*-plan.md; do
  [ -f "$f" ] || continue
  v=$(fm "$f" version); st=$(fm "$f" status); sh=$(fm "$f" shipped_at); tk=$(fm "$f" task)
  plans="$plans ${v:-?}:${st:-?}${sh:+($sh)}"
  case "$st" in
    운영중)
      n_run=$((n_run+1)); run_tasks="$run_tasks
${tk:-$v}"
      if [ -n "$sh" ] && { [ -z "$latest_ship" ] || [[ "$sh" > "$latest_ship" ]]; }; then latest_ship="$sh"; fi ;;
    구현중) n_build=$((n_build+1)) ;;
    기획) n_plan=$((n_plan+1)) ;;
  esac
done
n_task=$(printf '%s\n' "$run_tasks" | sed '/^$/d' | sort -u | wc -l | tr -d ' ')
if [ -f "$D/log.md" ]; then
  log_rows=$(grep -cE '^\| *20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$D/log.md")
  last_log=$(grep -oE '^\| *20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$D/log.md" | tail -1 | tr -d '| ')
  recent_logs=$(awk -F'|' -v s="$latest_ship" '$2 ~ /20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ {d=$2; gsub(/ /,"",d); if (s=="" || d>=s) c++} END{print c+0}' "$D/log.md")
fi
run_days=""; [ -n "$latest_ship" ] && run_days=$(days_since "$latest_ship")

if [ "$ctx" = "스폰지클럽 저장소" ]; then
  rec="프로젝트 경로 필요 — 스폰지클럽 저장소 안에는 docs/ops-os 를 만들지 않는다"
elif [ ! -f "$D/00-map.md" ]; then
  rec="① 처음"
elif [ "$n_build" -gt 0 ]; then
  rec="이어서 구현 — 구현중인 기획안이 있음"
elif [ "$n_run" -gt 0 ]; then
  if [ "$n_plan" -gt 0 ]; then
    rec="② 이어서 — 새 기획안이 기다리는 중"
  elif [ "$recent_logs" -ge 2 ] && { [ "$recent_logs" -ge 5 ] || { [ -n "$run_days" ] && [ "$run_days" -ge 7 ]; }; }; then
    rec="② 다시"; [ "$n_task" -ge 2 ] && rec="$rec · v3 연결 후보 (운영중인 일 ${n_task}개)"
  else
    rec="아직 이르다 — log ${recent_logs}줄 · ${run_days:-?}일째. log 2줄 이상 + (5줄 또는 7일) 뒤에 다시"
  fi
elif [ "$n_plan" -gt 0 ]; then
  rec="③ 이어서 — 기획안 있음 (구현하려면 ①)"
else
  rec="① 처음 — 지도 있음, v1 고르기부터"
fi

echo "| 항목 | 값 |"
echo "|---|---|"
echo "| 맥락 | $ctx |"
echo "| 경로 | $(pwd) |"
echo "| docs/ops-os | $([ -d "$D" ] && echo 있음 || echo 없음) |"
echo "| 운영 지도 행 | $map_rows |"
echo "| 기획안 | ${plans:- 없음} |"
echo "| 운영중인 일 | $n_task |"
echo "| log 줄 | $log_rows (최근 운영중 이후 $recent_logs · 마지막 ${last_log:-없음}) |"
echo "| 최근 운영 시작 | ${latest_ship:-없음}${run_days:+ · ${run_days}일째} |"
echo ""
echo "추천: $rec"
