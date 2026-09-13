# 13 · 현황 — 단가·공식 연결·기한·브라우저 도구 (날짜 박힌 파일)

**기준일: 2026-09-13.** 값이 바뀌는 사실은 이 파일 한 곳에만 둔다. 다른 파일과 기획안은 값 대신 **ID**(예: `L-A3`)로 가리키고, 기획안에 값을 옮겨 적을 때는 ID 와 기준일을 같이 적는다. 기준일이 90일 넘게 지났으면 기획안 §5 에 "현황 확인 필요"를 붙인다.

## A. 단가·요금

| ID | 대상 | 값 | 출처 |
|---|---|---|---|
| L-A1 | 볼타 전자세금계산서 API | 정발행 90원/건 · 역발행 200원/건 · 최소 사용료 없음 (볼타 자체 발표) | bolta.io/insight/tax-invoice-api-guide |
| L-A2 | 팝빌 · 바로빌 전자세금계산서 API | 단가 비공개(문의) — L-E1 | popbill.com/Taxinvoice/API · barobill.co.kr/partner/info.asp |
| L-A3 | 솔라피 알림톡 · 문자 | 알림톡 13원 · SMS 18원 · LMS 45원 · 월 기본료 없음 | solapi.com/pricing |
| L-A4 | 카카오 브랜드 메시지 | 텍스트 53원 · 채널 친구가 아닌 사람에게 보내기는 채널 친구 5만 명 이상 (제3자 출처) | inside.ampm.co.kr/insight/59098 |
| L-A5 | 시프티 (근태·스케줄) | 새로 쓰는 20인 미만 회사 BASIC 무료 | shiftee.io/en/pricing |
| L-A6 | 캐시노트 | 급여명세서 카카오톡 발송 무료 · 홈택스 연동 부가세 예상세액 무료 | talk.cashnote.kr/article/content/30427 |
| L-A7 | 모두싸인 (전자계약) | Team 39,900원/월 (30건) | modusign.co.kr/pricing |
| L-A8 | Claude in Chrome | 유료 Claude 플랜(Pro·Max·Team·Enterprise)에 포함 | support.claude.com/en/articles/12012173 |
| L-A9 | ego lite | 무료 · MIT 오픈소스 · macOS 전용 | lite.ego.app |
| L-A10 | Aside | Free(월 500 크레딧 · 루틴 3개) · Pro $20/월 · Max $200/월 — L-E5 | aside.com/pricing |
| L-A11 | Playwright | 무료 · 오픈소스 | playwright.dev |

## B. 공식 연결(API) 상태

| ID | 대상 | 상태 | 출처 |
|---|---|---|---|
| L-B1 | 국세청 사업자등록 상태조회 | 무료 · 공공데이터포털 인증키 · 휴업·폐업 여부 확인 | data.go.kr/data/15081808/openapi.do |
| L-B2 | 네이버 커머스API (스마트스토어) | 무료 · 내스토어 애플리케이션 초당 2회 | github.com/commerce-api-naver/commerce-api/discussions/6 |
| L-B3 | 네이버 예약 | 공개 API 확인 못 함 — L-E4 | — |
| L-B4 | 네이버 블로그 글쓰기 | 2020년 종료 | newsis.com NISX20200413_0000992012 |
| L-B5 | Instagram API | 게시: 프로페셔널 계정 · 공개 주소의 JPEG · 24시간 100건. DM: 고객이 보낸 뒤 24시간 안에만 답장, 본인 계정은 Standard Access 라 앱 리뷰 불필요 | developers.facebook.com/docs/instagram-platform/content-publishing |
| L-B6 | Threads API | 24시간 250건 · 실서비스는 App Review (제3자 출처) | blotato.com/blog/threads-api-pricing |
| L-B7 | 카카오 친구톡 | 2025-12-31 종료 → 브랜드 메시지로 전환 | solapi.com/blog/kakaotalk-brand-message-notice |
| L-B8 | 카카오 오픈채팅 · 채널 1:1 채팅 | 읽기·쓰기 공개 API 없음 (상담톡은 기업 상담센터용) | kakaobusiness.gitbook.io/main/ad/cstalk |
| L-B9 | 4대보험 EDI | 공개 API 없음 · 웹 신고 무료 | edi.nhis.or.kr |
| L-B10 | 홈택스 사업자 간편인증 | 2026-04 부터 (카카오뱅크·IBK기업은행·KB국민은행 앱) · 홈택스 화면에서만, 발급 API 업체에는 적용 안 됨 | startupn.kr/news/articleView.html?idxno=58173 |
| L-B11 | GA4 Data API · Google Sheets API | GA4 표준 속성 하루 20만 토큰 · Sheets 읽기 사용자당 분당 60회 | developers.google.com/analytics/devguides/reporting/data/v1/quotas · developers.google.com/workspace/sheets/api/limits |

## C. 기한·법

| ID | 대상 | 내용 | 출처 |
|---|---|---|---|
| L-C1 | 전자세금계산서 발급 기한 | 공급일이 속한 달의 다음 달 10일 · 지연발급 가산세 1% · 미발급 2% | nts.go.kr (발급기한) |
| L-C2 | 전자세금계산서 의무 발급 | 법인 전부 · 개인사업자는 직전 과세기간 공급가액(과세+면세) 8천만 원 이상 | nts.go.kr (의무발급 대상) |
| L-C3 | 임금명세서 | 모든 사업장(5인 미만·알바 포함), 임금 줄 때 교부 · 전자문서 가능 · 기재사항 누락 과태료 최대 500만 원 | easylaw.go.kr (임금명세서) |
| L-C4 | 부가세 신고·납부 | 개인 일반과세자: 1기 확정 7/25 · 2기 확정 다음 해 1/25 (예정분은 고지 납부) · 법인: 4/25 · 7/25 · 10/25 · 1/25 · 간이과세자: 다음 해 1/25 — 세부는 L-E8 | nts.go.kr |
| L-C5 | 광고성 정보 전송 | 사전 수신동의 · 앞에 (광고) · 수신거부 방법 · 21~08시는 별도 야간 동의 · 수신동의 사실 2년마다 알림 · 과태료 최대 3천만 원. 상세는 sponge-security-check `references/12-legal.md` | 정보통신망법 제50조 |
| L-C6 | 알림톡 준비 기간 | 카카오 비즈니스 채널 심사 3~7영업일 · 템플릿 검수 1~3영업일 · 정보성 메시지만 | solapi.com/guides/kakao-ata-guide |
| L-C7 | 4대보험 자격 취득·상실 신고 | 사유가 생긴 날이 속한 달의 다음 달 15일까지 | 4대사회보험 정보연계센터 |

## D. 브라우저 에이전트 현황

| ID | 도구 | 현황 | 출처 |
|---|---|---|---|
| L-D1 | Claude in Chrome | 2026-08-26 정식 출시 · 내 Chrome 로그인 그대로 · Claude Code 는 `claude --chrome` 또는 `/chrome` (API 키 로그인 세션은 불가) · Desktop 앱은 커넥터 · 예약 작업은 Chrome 이 열려 있을 때만 · 로그인·캡차에서 멈추고 사람에게 넘김 | code.claude.com/docs/en/chrome |
| L-D2 | ego lite | Citro Labs · 스킬 + `ego-browser nodejs` 스크립트 (MCP 아님) · Chrome 로그인·쿠키 가져오기는 선택 · 에이전트는 백그라운드 Space 에서 일하고 `task.handOff()` 로 사람에게 넘긴 뒤 이어받음 · headless·예약 기능 없음 · 앱을 끄면 탭이 사라짐 | lite.ego.app · github.com/citrolabs/ego-lite |
| L-D3 | Playwright | MCP `claude mcp add playwright npx @playwright/mcp@latest` (기본은 워크스페이스별 유지 프로필 · `--isolated` · `--storage-state` · `--extension` 은 실제 Chrome) · CLI `@playwright/cli` · codegen `--save-storage` · headless 가능 | github.com/microsoft/playwright-mcp · playwright.dev/docs/codegen |
| L-D4 | Aside | YC F25 · Chromium 기반 자체 브라우저 · AI 가 값을 못 보는 비밀번호 관리자 · 크론 루틴 · `aside mcp` · 권한 모드 Read only / Guard(기본) / Full access · CLI 설치는 `curl \| bash` 스크립트 | docs.aside.com |

## E. 미검증 — 기획안에 쓰기 전에 확인

| ID | 항목 | 상태 |
|---|---|---|
| L-E1 | 팝빌·바로빌 단가 | 공개 요금이 없음. 기획안에는 "문의 필요"로 |
| L-E2 | 인스타 DM 한도가 시간당 200건으로 줄었다는 주장 | 제3자 출처만 있음 |
| L-E3 | Sheets API 한도 초과분이 2026년에 유료가 된다는 주장 | 제3자 출처만 있음 |
| L-E4 | 네이버 예약 파트너 API | 공개 여부 확인 못 함 |
| L-E5 | Aside 요금 | 공식 요금 페이지와 제3자 리뷰가 다름 |
| L-E6 | ego lite Space 간 쿠키 분리 | 공식 문서는 분리, GitHub 이슈 #303·#319 와 리뷰는 공유된다고 함 → 로그인 최소 전용 프로필 권장 |
| L-E7 | ego lite 권한 모드 | 공식 안내는 권한 확인을 끄는 모드를 권함 → 이 스킬은 끄지 않고 명령마다 승인 |
| L-E8 | 부가세 기한 세부 | 예정고지·예정신고 대상, 간이과세 전환 등은 홈택스·세무사 확인 |

## F. 갱신 절차 (운영진 월 1회 · 크루는 선택)

1. A·B·D 표의 출처 주소를 WebFetch 로 열어 값을 확인한다.
2. E 항목 중 확인된 것은 A~D 로 옮기고, 틀린 것은 고친다.
3. 바뀐 줄만 보고한다. 기준일을 오늘로 바꾸고 CHANGELOG 에 한 줄, 커밋.
