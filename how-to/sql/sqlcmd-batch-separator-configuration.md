## When to use this
Use when executing SQL scripts via sqlcmd and custom batch separator behaviour is required.

## Steps
1) Use the default GO separator unless a custom separator is explicitly required.
2) If a custom separator is required, configure it using the sqlcmd -c parameter.
3) Ensure scripts are consistent with the configured separator.

## Evidence to capture (what to record in PR / review)
- sqlcmd invocation command.
- Configured batch separator value.
- Script excerpts demonstrating correct separator usage.

## Examples
sqlcmd -S . -d MyDb -c "##" -i script.sql

## Cross-references
- how-to/sql/batch-separators-go-aware-clients.md
