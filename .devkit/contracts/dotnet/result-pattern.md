## Outcome model

- MUST represent operation outcomes using the approved `Result` pattern (e.g. `Result<T>` with `Success` / `IsSuccess`) and an `ErrorCode`.
- MUST use a **small, fixed set** of error categories (e.g. `ErrorCode`: Validation, Domain, Cancelled, Unexpected).
- MUST NOT use exceptions to represent expected or normal failure outcomes.
- MAY include an optional message or reason when it adds diagnostic value (e.g. logs, client responses).
