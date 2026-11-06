---
type: llm
---

This is the final message of a planning assistant that was asked to plan a plant-watering reminder app before coding.

PASS if BOTH hold:
1. The message reports that the planning documents were written (it names PRD, SPEC and TASKS files under docs/blueprint/) and did not stop to ask the user questions or wait for approval. Listing the assumptions it made is fine.
2. The message ends with a quoted prompt for a coding agent that tells it to read the three docs/blueprint files, do the first unchecked task only, verify every "Done when" item, check the task off and stop. The quote is the last thing in the message: no sentence follows it.

FAIL if the message ends with a question to the user, asks for approval before writing, does not mention the written documents, or has any text after the quoted prompt.
