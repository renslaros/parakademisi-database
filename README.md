# parakademisi-database

Database management for Parakademisi platform.

- **ORM:** Drizzle
- **Databases:** Neon (Postgres), Upstash (Redis), Timescale (event logging)
- **Local dev:** Docker Compose
- **Migrations:** src/migrations/
- **Seeds:** src/seeds/
- **Models:** src/models/
- **Config:** src/config/
- **Scripts:** src/scripts/
- **.env.example:** for local/remote/prod config

## Common Commands

- Start local DBs: `docker-compose up -d`
- Run migrations: `pnpm drizzle-kit migrate:latest` or `pnpm run migrate`
- Seed DB: `pnpm run seed`
- Reset DB: `pnpm run reset`

## Security

- Only CTO/lead engineers have access to core DBs and migrations.
- All other devs have read/write access only to their own data (via API or DB roles).
- Secrets are managed via environment variables and cloud secrets managers.
- All DB access and changes are logged and auditable.

## Docs

- See `/docs/` for more info.
