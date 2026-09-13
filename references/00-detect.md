# 00 · 상태·맥락 파악

첫 동작이다. 키·비밀번호·연락처·금액 값은 어디에도 출력하지 않는다. 명령은 전부 읽기 전용이다.

## 1. 어디서 불렸나

| 맥락 | 알아보는 법 | 상태 파일 위치 | 할 일 |
|---|---|---|---|
| 스폰지클럽 저장소 | 지금 폴더나 git 최상위 폴더에 `1_mission/` 과 `3_session_skills/` 가 같이 있음. **과제 폴더 안에 넣어 둔 랜딩 폴더도 여기** | **이 저장소 안 어디에도 만들지 않는다** | 닉네임을 묻고 제출물을 읽은 뒤, 상태 파일을 둘 바깥 폴더(원래 프로젝트 저장소 또는 새 폴더)를 묻는다 (10-interview Q0) |
| 코드 저장소 | `package.json` · `pyproject.toml` · `index.html` 등 | 이 저장소 `docs/ops-os/` | 그대로 진행 |
| 코드 없음 | 둘 다 아님 | Q0 로 정한 폴더의 `docs/ops-os/` | 랜딩과 무관한 운영일 가능성이 크다 → 사다리 1·2칸 우선 |

## 2. 상태 파일 — `scripts/state.sh`

```bash
bash ~/.claude/skills/sponge-ops-os/scripts/state.sh <프로젝트 경로>
```

표와 마지막 줄 `추천:` 을 출력한다. 아무것도 쓰지 않는다. `대체됨` 버전은 세지 않고, 운영중인 일은 `task` 로 센다.

| 추천 | 모드 |
|---|---|
| ① 처음 | ① (사용자가 "지도만"이면 ③) |
| ① 처음 — 지도 있음 | ① 을 S6 부터. 지도를 보여 주고 틀린 칸만 확인 |
| ③ 이어서 — 기획안 있음 | 준비가 끝났으면 모드 ① 7단계(구현)부터, 아직이면 §5 체크리스트만 확인 |
| 이어서 구현 | 모드 ① 7단계부터 (vN 이면 모드 ② 4단계) |
| ② 다시 / ② 이어서 | ② (「v3 연결 후보」가 붙으면 30-revisit 규칙 2 부터 확인) |
| 아직 이르다 | log 한 줄 적는 법만 안내하고 끝. 월 단위 일이면 한 주기 뒤. 사용자가 원하면 ② 로 가되 숫자에 "추정" |
| 프로젝트 경로 필요 | §1 스폰지클럽 저장소 행대로 |

## 3. 흐름 원천 — 1차 전환 흐름을 어디서 읽나

스폰지클럽 크루면 `1_mission/{조}/{닉네임}/` 을 `ls` 로 먼저 보고, 위에서부터 **채워진** 것을 쓴다. 칸 제목만 있는 빈 양식은 없는 것으로 친다. 제출물은 읽기만 한다.

| 순서 | 파일 | 읽을 절 |
|---|---|---|
| 1 | `*6회차 과제*/submission.md` | `### 01-5. 전체 유저 플로우` (+ 01-3 혜택, 01-4 가두리망) |
| 2 | `*2회차 과제*/submission.md` | `### 08. 유저 플로우` (+ 04 가두리망 채널) |
| 3 | `*3회차 과제*/submission.md` | `## 02. CRM 세팅` 의 02-2·02-3 (보내는 메시지) · `01-5. 어디서 끊겼나` |
| 4 | `*5회차 과제*/submission.md` | `02-4. 어디서 끊겼나` · `## 삽질과 인사이트` |
| 5 | 프로젝트 저장소 | 랜딩 폼 → 저장 표 → 발송 코드 순서로 AI 가 흐름을 추정 |
| — | 없음 | S2 흐름 걷기를 건너뛰고 S3 털어놓기부터 |

"손으로", "매번", "직접 보냅니다", "옮겨 적" 같은 표현은 흐름 속 손일 후보다. 그대로 인용해 근거로 적는다. 모집 마감일이 적혀 있으면 같이 적는다 (게이트 G5).

## 4. 저장소 운영 흔적

```bash
# 어드민 · 저장 표 · 예약
ls -d admin app/admin src/app/admin pages/admin app/tools src/app/tools 2>/dev/null
ls supabase/migrations 2>/dev/null | tail -5
grep -rhoE "\.from\(['\"][a-z0-9_]+['\"]\)" --include='*.ts' --include='*.tsx' --include='*.js' --exclude-dir=node_modules . 2>/dev/null | sort -u | head -20
grep -A4 '"crons"' vercel.json 2>/dev/null

# 발송 코드 (메일·문자·알림톡·Apps Script)
grep -rliE "resend|nodemailer|sendgrid|solapi|aligo|coolsms|twilio|alimtalk|MailApp|GmailApp" --include='*.ts' --include='*.tsx' --include='*.js' --include='*.gs' --include=package.json --exclude-dir=node_modules . 2>/dev/null | head

# 환경변수 이름만 (값은 읽지 않는다)
grep -hoE "^[A-Z][A-Z0-9_]+=" .env.example .env.local 2>/dev/null | sort -u

# 시트 · Apps Script · 기존 운영 문서
ls -d ops docs/ops-os 2>/dev/null
grep -rlE "docs.google.com/spreadsheets|script.google.com" --include='*.md' --include='*.ts' --include='*.tsx' --include='*.js' --include='*.gs' --include='*.html' --exclude-dir=node_modules . 2>/dev/null | head -5

# 프로젝트 스킬 · 저장소 공개 여부
ls .claude/skills 2>/dev/null
gh repo view --json visibility -q .visibility 2>/dev/null
```

## 5. 설치된 스킬·도구

```bash
ls -d ~/.claude/skills/sponge-admin-kit ~/.claude/skills/sponge-security-check ~/.claude/skills/ego-browser 2>/dev/null
```

브라우저 도구 확인은 `21-browser-agents.md` F 절. Claude in Chrome 은 세션 도구 목록에 `mcp__claude-in-chrome__` 도구가 있거나, 지연 로드 목록에 이름이 있으면(불러와서 쓸 수 있음) 연결 가능으로 본다. 둘 다 없으면 사용자에게 묻는다.

## 6. 보여 줄 표

| 항목 | 값 | 근거 |
|---|---|---|
| 맥락 | 코드 저장소 / 스폰지클럽 저장소 / 코드 없음 | §1 |
| 프로젝트 경로 | | |
| 스택 | 프레임워크 · 호스팅 · DB | package.json · 설정 파일 |
| 어드민 | 경로 / 없음 | §4 |
| 저장 표 | 이름 목록 | 마이그레이션 · `.from()` |
| 발송 코드 | 서비스 이름 / 없음 | §4 |
| 예약·cron | 있음 / 없음 | vercel.json |
| 시트·Apps Script 흔적 | | §4 |
| 저장소 공개 여부 | public / private / 확인 불가 / git 아님 | gh |
| 흐름 원천 | 6회차 01-5 / 2회차 08 / … / 없음 | §3 |
| docs/ops-os 상태 | state.sh 추천 줄 | §2 |
| 설치된 형제 스킬 | admin-kit · security-check | §5 |
| 브라우저 도구 | Chrome · ego lite · Playwright · Aside 중 있는 것 | 21 F |

## 7. 저장소로 알 수 없는 것 → 인터뷰로

운영 인원, 사업 모양, 손일의 주기·시간·사람 몫, 털어놓기, 준비물(사업자등록·카카오 비즈니스 채널·홈택스 인증 방식·구글 계정), 기준선. 저장소나 제출물에서 이미 확인된 것은 묻지 않는다.
