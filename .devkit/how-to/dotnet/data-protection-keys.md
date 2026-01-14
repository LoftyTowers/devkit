# Data Protection keys

## Why persistence is required
- Multi-instance and containerized deployments must share keys to decrypt existing cookies and CSRF tokens.
- Ephemeral keys cause sign-in failures and invalid protected data after restarts or scale-out.

## Shared persistence patterns
- Persist keys to a shared store accessible by all instances (e.g., database, blob/file share, or distributed cache).
- Keep provider choice aligned with platform constraints; avoid bespoke crypto.

## Protect at rest
- Restrict access to key material to the app identity.
- Encrypt key storage where the platform supports it.

## Rotation and retention
- Enable key rotation; keep old keys long enough to decrypt existing protected data.
- Do not delete keys unless data loss is explicitly accepted.
