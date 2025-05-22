# General Rules for parakademisi-database

- Only CTO/lead engineers have access to core DBs and migrations.
- All other devs have read/write access only to their own data (via API or DB roles).
- Secrets are managed via environment variables and cloud secrets managers.
- All DB access and changes are logged and auditable.
- All code must be modular, DRY, type-safe, and serverless/stateless.
- All onboarding, setup, and maintenance is automated and documented.
