# SQL Server checklist

Use this checklist during code review, schema review, or production issue triage.

See also: .devkit/checklists/sql/query-design.md

## Schema design
- Every table has a PRIMARY KEY.
- PRIMARY KEY columns are NOT NULL.
- PRIMARY KEY definitions do not exceed SQL Server limits (32 columns or 900 bytes total key length).
- Foreign key column data types exactly match referenced column data types.
- Foreign keys target PRIMARY KEY or UNIQUE constraints.
- Designs do not assume SQL Server auto-indexes foreign key columns.
- Deprecated types TEXT/NTEXT/IMAGE are not used.
- The same logical attribute uses the same data type across tables.

## Constraints
- CHECK constraints handle NULL explicitly when NULL must be rejected.
- Designs do not rely on CHECK constraints to block DELETE operations.
- DEFAULT constraints are explicitly named.
- Designs do not rely on DEFAULT constraints to change values on UPDATE.
- Computed columns are not inserted or updated directly.
- Computed columns are not used in DEFAULT or FOREIGN KEY constraints.
- Sparse column restrictions are respected when sparse columns are used.

## Queries
- NULL comparisons use IS NULL / IS NOT NULL (not = or !=).
- Queries select only required columns (avoid SELECT * for schema-change safety).
- Queries do not rely on physical column order.

## Indexing
- Indexes align to real query patterns (read/write trade-offs considered).
- Avoid over-indexing heavily updated tables.
- Avoid unnecessary or wide indexes (only include required columns).
- Index usage is monitored and unused indexes are removed over time.

## Indexing (Blob C)
- Clustered index count is 0 or 1.
- Composite key order follows equality then range then sort; distinctness order considered.
- Key column limits respected (16 columns, 900 bytes total key size).
- INCLUDE column limit respected (1,023 columns).
- INCLUDE columns are not treated as key columns for seeks/range scans.
- Filtered index predicates use only allowed forms (no LIKE, OR, computed predicate, or multi-table references).
- No redundant or superseded indexes (leading key coverage checked).
- No numeric selectivity thresholds stated as authoritative.
- If a heap is used, the scenario justification matches allowed deviation patterns.

## Transactions and locking
- Transaction boundaries are explicit where correctness depends on them.
- Long-running transactions avoided.
- Isolation level choices are deliberate.
- Deadlock risks are considered for hot paths.
- Concurrency approach is documented where it affects correctness.

## Transactions and error handling (Blob D)
- Autocommit vs explicit vs implicit transaction usage is intentional; no implicit mode without commit/rollback logic.
- Nested transaction ownership and savepoint usage are explicit; inner procedures do not rollback caller-owned transactions.
- Isolation level selection documents anomaly trade-offs; NOLOCK is not used for correctness-critical reads.
- Deadlock avoidance patterns are applied (short transactions, consistent ordering, no user interaction in transactions).
- TRY...CATCH patterns include explicit rollback or commit decision logic and error propagation.
- XACT_STATE is used in CATCH to choose rollback vs commit; @@TRANCOUNT alone is not used for committable decisions.
- XACT_ABORT usage is explicit where required, and its limitations are understood.
- Row-versioning isolation impacts (version store, tempdb) are considered where enabled.
- Retry-safe design is intentional; idempotency is addressed or retries are avoided.

## Migrations
- EF Core migrations are versioned, reviewed, and repeatable. (Dotnet scope)
- Migration scripts avoid destructive surprises. (Dotnet scope)
- Rollback strategy exists (where required). (Dotnet scope)
- Deployment order and app/db compatibility is considered. (Dotnet scope)

## Security
- Principle of least privilege for database users/roles.
- Sensitive data handling considered (encryption, access controls where required).
- No secrets stored in plain text in the repository.
- Auditing/traceability considered for sensitive operations (where required).

## Blob E — SQL Artefacts & Encapsulation
### Stored procedures — parameter contracts and calls
- Stored procedure parameters use explicit data types and direction; treated as a public contract.
- Stored procedure calls use named parameters (not positional) for compatibility.
- Parameters are not used to substitute object identifiers; identifiers are not parameterized.
- Positional stored procedure calls are avoided where signature evolution could break compatibility.
- Parameterizing object names (for example, FROM @TableName) is not used.
- No deviations beyond using named parameters as the compatibility mechanism.

### EF Core interaction — stored procedures and raw SQL shape contracts
- When EF Core consumes SQL artefacts, result shapes match EF Core mappings and column names.
- Stored procedure signatures and shapes follow EF Core conventions when EF Core is configured to use them.
- Result-set shape changes are reviewed for EF Core mapping impact.
- No deviations explicitly identified.

### Views — semantics and controlled read surface
- Views are treated as logical read abstractions, not inherent performance features.
- When used for security abstraction, permissions are granted on views and withheld on base tables.
- Non-indexed views are not assumed to improve performance.
- Broad base-table permissions are not granted when access should be mediated via views.
- No deviations explicitly identified.

### Indexed views — creation constraints and DML overhead
- Indexed views are created only when documented requirements and limitations are satisfied.
- DML overhead on base tables is evaluated before relying on indexed views in production.
- Indexed views are not created without meeting requirements.
- Indexed views are not introduced without testing write-path impact.
- No deviations beyond using indexed views only when requirements are met and need is proven.

### Functions — inline TVFs vs scalar UDFs vs multi-statement TVFs
- Inline TVFs are preferred for performance-critical logic.
- For composable query logic, inline TVFs or views are preferred over multi-statement TVFs.
- Scalar UDF inlining is not assumed to apply universally.
- Scalar UDFs are treated as a last resort in hot paths.
- Hot-path designs do not assume scalar UDF inlining will ensure performance.
- Multi-statement TVFs are not used for composable or performance-critical logic without profiling evidence.
- Scalar UDFs are not banned; caution is about inlining assumptions and hot-path reliance.

### Triggers — transactional behaviour, locking, and restrained use
- Triggers are designed with transaction scope and lock duration in mind; kept short and fast.
- Triggers are used only where constraints or stored procedures cannot express the rule.
- Triggers use set-based logic over inserted/deleted for multi-row correctness.
- Long-running or complex trigger logic that increases blocking is avoided.
- Triggers are not used for non-critical side effects where failure should not abort the transaction.
- Row-by-row trigger logic that assumes single-row semantics is not used.
- Triggers are justified for complex integrity rules not expressible by constraints when needed.
- Triggers are justified for legacy audit behaviors when temporal tables are not usable.

### Temporal tables — system-versioned history
- Temporal tables are preferred when automatic row history is required and constraints are acceptable.
- Temporal-table operational constraints are respected.
- Trigger-based auditing is not the default when temporal tables satisfy requirements.
- Direct history modification while SYSTEM_VERSIONING is ON is not attempted.
- Non-temporal audit mechanisms are allowed when temporal tables do not meet requirements.

### Security boundaries — ownership chaining and cross-database chaining
- Ownership chaining and EXECUTE AS are used deliberately to encapsulate access via procs/views.
- Cross-database ownership chaining is not enabled without explicit justification and documentation.
- Accidental ownership chains are not relied on as unreviewed security boundaries.
- Cross-database ownership chaining is not enabled as a convenience shortcut.
- Cross-database ownership chaining is allowed only with explicit justification and documentation.

### Soft delete — authority boundary and decision signaling
- No soft delete pattern is presented as vendor-mandated or universally preferred.
- Soft delete is treated as an explicit local design decision, not a default.
- Claims that soft delete is always better than hard delete are not used as authoritative rules.
- No single soft delete pattern is encoded as mandatory based on vendor authority.
- Any soft delete pattern may be chosen locally when explicitly documented as a design decision.
