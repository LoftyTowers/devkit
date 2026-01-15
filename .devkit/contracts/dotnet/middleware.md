# Middleware

- Central exception handling middleware/filters MUST convert unhandled exceptions into HTTP 5xx **ProblemDetails** responses (sanitised; no sensitive internals).
