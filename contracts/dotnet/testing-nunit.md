## Testing

- MUST use **NUnit** as the test framework.
- SHOULD use **FluentAssertions** for assertions and **Moq** for mocking.
- MUST name test methods using the pattern `<Method>_<Condition>_<ExpectedOutcome>`
  (e.g. `PayAsync_InvalidInput_ReturnsBadRequest`).
