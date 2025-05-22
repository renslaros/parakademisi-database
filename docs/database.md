# Database Design & Management

## Overview

- Uses Drizzle ORM for schema, migrations, and seeding.
- Neon (Postgres) for relational data.
- Upstash (Redis) for cache/pubsub.
- Timescale for event logging/analytics.

## Local Development

- Start local DBs: `docker-compose up -d`
- Run migrations: `pnpm drizzle-kit migrate:latest`
- Seed DB: `pnpm run seed`
- Reset DB: `pnpm run reset`

## Security

- Only CTO/lead engineers have access to core DBs and migrations.
- All other devs have read/write access only to their own data (via API or DB roles).
- Secrets are managed via environment variables and cloud secrets managers.
- All DB access and changes are logged and auditable.

## Migrations

- All migrations are in `/src/migrations/`.
- Use Drizzle migration system for all schema changes.

## Seeding

- All seed scripts are in `/src/seeds/`.
- Use `pnpm run seed` to seed the DB.

## Multi-Tenancy & Region

- All models must include `tenantId` and `region` fields.
- Data is partitioned by tenant and region for compliance and performance.

## Docs

- See `/docs/` for more info.
