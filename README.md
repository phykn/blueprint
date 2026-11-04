# blueprint

바이브코딩에서 코드는 AI가 짭니다. 사람이 할 일은 **좋은 문서를 쓰는 것**입니다.

`blueprint`는 대충 떠오른 아이디어를 AI 코딩 에이전트(Claude Code, Codex 등)가 추측 없이 바로 작업할 수 있는 문서로 바꿔 주는 스킬입니다.

## 만들어 주는 문서

| 파일 | 내용 |
|---|---|
| `docs/PRD.md` | 왜 만드는지, 누구를 위한 것인지, 무엇을 하고 무엇을 안 하는지, 언제 완성인지 |
| `docs/SPEC.md` | 어떻게 만드는지: 기술 스택, 화면, 데이터, 결정과 그 이유 |
| `docs/TASKS.md` | 에이전트가 하나씩 처리할 작업 목록과 완료 기준 |

## 동작 방식

1. **인터뷰**: 쉬운 말로 한 번에 하나씩, 선택지와 함께 질문합니다. 개발을 몰라도 됩니다.
2. **설계**: 기술 선택이 필요하면 스킬이 이유와 함께 제안합니다. 실험해 봐야 아는 것(모델 구조 등)은 후보와 고르는 기준으로 남깁니다.
3. **계획**: 처음부터 끝까지 동작하는 최소 기능(또는 베이스라인)부터 만들도록 작업 순서를 정합니다.
4. **리뷰**: 문서마다 사람이 승인한 뒤에도 AI가 체크리스트로 다시 검토해서 빠진 부분과 모순을 알려줍니다.

웹앱뿐 아니라 딥러닝 모델처럼 데이터를 다루는 프로젝트도 지원합니다. 문서는 대화하는 언어로 작성됩니다.

## 설치

### Claude Code

```text
/plugin marketplace add phykn/blueprint
/plugin install blueprint@blueprint
```

이미 설치했다면 업데이트 후 `/reload-plugins`를 실행하세요.

### Codex와 ChatGPT 데스크톱 앱

```text
codex plugin marketplace add phykn/blueprint
codex plugin add blueprint@blueprint
```

플러그인이 바로 보이지 않으면 ChatGPT 데스크톱 앱을 다시 시작하세요.

### 직접 복사

플러그인 없이 쓰려면 `skills/blueprint` 폴더를 각 도구의 스킬 경로에 복사하세요. [Agent Skills](https://agentskills.io) 표준 형식(`SKILL.md` + 참고 파일)이라 그대로 동작합니다.

| 도구 | 개인용 (모든 프로젝트) | 프로젝트용 |
|---|---|---|
| Claude Code | `~/.claude/skills/blueprint` | `<project>/.claude/skills/blueprint` |
| Codex | `~/.agents/skills/blueprint` | `<project>/.agents/skills/blueprint` |

## 사용

"앱 아이디어가 있는데 문서부터 만들어 줘", "이 모델 만들기 전에 PRD 써 줘"처럼 말하면 스킬이 자동으로 실행됩니다. 직접 부르려면 Claude Code에서는 `/blueprint` (플러그인으로 설치했다면 `/blueprint:blueprint`), Codex에서는 `$blueprint`를 입력하세요.

## 구조

```
.claude-plugin/           # Claude Code 플러그인·마켓플레이스 메타데이터
.codex-plugin/            # Codex 플러그인 메타데이터
.agents/plugins/          # Codex 마켓플레이스
skills/blueprint/
├── SKILL.md              # 스킬 지침
├── templates/
│   ├── PRD.md
│   ├── SPEC.md
│   └── TASKS.md
└── references/
    └── checklist.md      # 문서 검토 기준
```

두 도구 모두 같은 `skills/blueprint/SKILL.md`를 읽습니다. 빌드 단계나 도구별 사본은 없습니다.
