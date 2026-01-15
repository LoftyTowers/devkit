# SQL Server authority boundaries playbook

The topics below have no authoritative Microsoft best-practice guidance and MUST NOT be elevated into contract rules without new authoritative sources:
- Normalisation vs denormalisation
- Natural vs surrogate keys
- Constraints vs application validation layering
- IDENTITY vs SEQUENCE decision criteria
- Persisted vs non-persisted computed column decision criteria
- MERGE concurrency safety (no Tier-1 universal rule in this blob's sources)
- Expand/contract (no Tier-1 mandate in this blob's sources)

Allowed patterns when explicitly labeled non-Tier-1:
- Expand/contract as an industry pattern when context requires it.
- Multi-step breaking-change approaches as context-dependent patterns.
