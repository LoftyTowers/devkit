# Diagnostic queries (SQL Server)

## When to use this
Use for ad-hoc investigation or short-lived diagnostic queries where schema evolution concerns are irrelevant.

## Steps
1) Limit usage to diagnostic contexts and avoid embedding in production application code.
2) Document the purpose, scope, and expected lifespan of the diagnostic query.
3) Review with the owner of the data surface if it will be retained beyond the immediate investigation.

## Evidence to capture (what to record in PR / review)
- Reason the diagnostic query requires SELECT *.
- Confirmation that the query is not part of application-facing behavior.
- Planned removal or deprecation timeline if it will persist.

## Examples
Good:
SELECT * FROM dbo.Payments WHERE PaymentId = @PaymentId; -- diagnostic only
Bad:
SELECT * FROM dbo.Payments; -- used in application client path

## Cross-references
- .devkit/contracts/sql/query-shape.md
- .devkit/playbooks/sql/query-shape.md
