# Result Pattern

## Scope

- Explicit outcome modeling for expected failures and API boundary mapping.

## Rules

### Outcome model

- Domain/service methods that can fail for expected business conditions MUST model failure explicitly using an approved explicit-outcome approach:
  `Result<T>`/`Result`, union/Either/OneOf, Try-pattern, or documented null/default/boolean.
- When using Result/union outcomes, MUST use a **small, fixed set** of error categories (e.g. `ErrorCode`: Validation, NotFound, Conflict, Cancelled, Unexpected).
- API boundary mapping MUST use these categories to produce 400 (Validation), 404 (NotFound), 409 (Conflict), and 500 (Unexpected).
- MUST NOT use exceptions to represent expected or normal failure outcomes.
- MAY include an optional message or reason when it adds diagnostic value (e.g. logs, client responses).
- Callers MUST branch on success/failure (or exhaustively match all union cases) before accessing the success value.
- MUST NOT access `Result.Value` (or equivalent) without checking success first.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
