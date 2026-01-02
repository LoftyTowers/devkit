# Exceptions

## Failure signalling for non-HTTP handlers
- SHOULD represent failures in non-HTTP operational handlers using result-like outcomes, events, or state transitions.
- MUST NOT rely on callers catching exceptions as the normal error signal.
