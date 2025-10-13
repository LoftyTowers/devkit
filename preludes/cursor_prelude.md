Apply local rules from .devkit:
- charter.md
- style.md
- patterns.md
- checklists.md

Tasks must include:
- summary + trade-offs (brief),
- minimal patch,
- tests,
- notes on logging/error/docs/perf.

When designing, first try the simplest direct code. Then check the **Extensibility decision table**:

- If calling external I/O → suggest **Port + Adapter**.
- If behaviour varies by type/rule/feature flag → suggest **Strategy**.
- If construction differs by config/env → suggest **Factory**.
- If adding cross-cut concerns (logging/caching/metrics) → suggest **Decorator**.

If none apply, say “no pattern needed” and keep it simple.
For any seam added, include a one-line reason: “Seam for X because Y”.

Keep code simple; follow the patterns. Do not skip tests or logging where they add value.
