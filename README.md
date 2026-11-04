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

`blueprint` 폴더는 [Agent Skills](https://agentskills.io) 표준 형식(`SKILL.md` + 참고 파일)이라 Claude Code와 Codex에서 그대로 쓸 수 있습니다. 폴더를 각 도구의 스킬 경로에 복사하세요.

| 도구 | 개인용 (모든 프로젝트) | 프로젝트용 |
|---|---|---|
| Claude Code | `~/.claude/skills/blueprint` | `<project>/.claude/skills/blueprint` |
| Codex | `~/.agents/skills/blueprint` | `<project>/.agents/skills/blueprint` |

```bash
# 예: 둘 다 개인용으로 설치
cp -r blueprint ~/.claude/skills/
mkdir -p ~/.agents/skills && cp -r blueprint ~/.agents/skills/
```

> Codex의 스킬 경로는 버전에 따라 다를 수 있습니다. 이전 버전은 `~/.codex/skills/`를 씁니다.

## 사용

"앱 아이디어가 있는데 문서부터 만들어 줘", "이 모델 만들기 전에 PRD 써 줘"처럼 말하면 스킬이 자동으로 실행됩니다. 직접 부르려면 Claude Code에서는 `/blueprint`, Codex에서는 `$blueprint`를 입력하세요.

## 구조

```
blueprint/
├── SKILL.md              # 스킬 지침
├── templates/
│   ├── PRD.md
│   ├── SPEC.md
│   └── TASKS.md
└── references/
    └── checklist.md      # 문서 검토 기준
```
