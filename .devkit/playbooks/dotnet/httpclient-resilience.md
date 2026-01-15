# HttpClient resilience (guidance)

## Policy composition and order
- Policy order MUST be intentional and documented where resilience is applied.
- Use a simple, documented ordering guideline tailored to the call (e.g., timeouts closest to the call; retries around transient failures).

## Manual policy composition (D2)
- Manual Polly composition MAY be used instead of the standard resilience handler when justified.
- The justification and chosen policy order MUST be documented.
