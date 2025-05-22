# Database & ORM Rules

- Use Drizzle ORM for all database code.
- All models must be defined in `/src/models/` using Drizzle's schema syntax.
- Use Neon for serverless Postgres; Timescale for event logging.
- Migrations must be created and run using Drizzle's migration system.
- All migrations must be idempotent and reversible.
- Use `/src/migrations/` for migration files, `/src/seeds/` for seed data.
- For multi-tenant/region-aware data, always include `tenantId` and `region` in models.
- All DB access must be via Drizzle; no raw SQL except for migrations/seeds.
- All code must be type-safe and covered by tests.
- For local dev, use `.env.local` for DB connection strings.
- For production, use environment variables and secrets manager.
- Document all models and migrations in `/docs/database.md`.
