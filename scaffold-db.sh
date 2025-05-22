#!/bin/bash

DB_REPO="parakademisi-database"


# 1. Drizzle config
cat <<EOF > src/config/drizzle.config.ts
import { defineConfig } from "drizzle-kit";
export default defineConfig({
  schema: "./src/models/*.ts",
  out: "./src/migrations",
  driver: "pg",
  dbCredentials: {
    connectionString: process.env.DATABASE_URL || "",
  },
});
EOF

# 2. Example Drizzle model
cat <<EOF > src/models/user.ts
import { pgTable, serial, text, timestamp } from "drizzle-orm/pg-core";

export const user = pgTable("user", {
  id: serial("id").primaryKey(),
  email: text("email").notNull().unique(),
  name: text("name"),
  createdAt: timestamp("created_at").defaultNow(),
});
EOF

# 3. Example migration (empty, Drizzle will generate)
touch src/migrations/.gitkeep

# 4. Example seed script
cat <<EOF > src/seeds/seed.ts
import { db } from "../config/db";
import { user } from "../models/user";

async function seed() {
  await db.insert(user).values([
    { email: "admin@parakademisi.org", name: "Admin" },
    { email: "student@parakademisi.org", name: "Student" }
  ]);
  console.log("Seeded users.");
}

seed().then(() => process.exit(0));
EOF

# 5. Example registry/manifest
cat <<EOF > src/registry/manifest.ts
export default {
  models: [
    "user",
    // Add more model names as you import them
  ],
  migrationsDir: "./src/migrations",
  seedsDir: "./src/seeds",
  configDir: "./src/config",
};
EOF

# 6. Example test
cat <<EOF > tests/user.test.ts
import { db } from "../src/config/db";
import { user } from "../src/models/user";

test("User table exists", async () => {
  const users = await db.select().from(user);
  expect(Array.isArray(users)).toBe(true);
});
EOF

# 7. Example .env.local
cat <<EOF > .env.local
DATABASE_URL=postgres://parakademisi:parakademisi@localhost:5432/parakademisi
REDIS_URL=redis://localhost:6379
TIMESCALE_URL=postgres://parakademisi:parakademisi@localhost:5433/parakademisi_events
DRIZZLE_MIGRATIONS_DIR=src/migrations
EOF

# 8. Example .cursor/rules files
cat <<EOF > .cursor/rules/database.rules.md
# Database & ORM Rules

- Use Drizzle ORM for all database code.
- All models must be defined in \`/src/models/\` using Drizzle's schema syntax.
- Use Neon for serverless Postgres; Timescale for event logging.
- Migrations must be created and run using Drizzle's migration system.
- All migrations must be idempotent and reversible.
- Use \`/src/migrations/\` for migration files, \`/src/seeds/\` for seed data.
- For multi-tenant/region-aware data, always include \`tenantId\` and \`region\` in models.
- All DB access must be via Drizzle; no raw SQL except for migrations/seeds.
- All code must be type-safe and covered by tests.
- For local dev, use \`.env.local\` for DB connection strings.
- For production, use environment variables and secrets manager.
- Document all models and migrations in \`/docs/database.md\`.
EOF

cat <<EOF > .cursor/rules/general.rules.md
# General Rules for parakademisi-database

- Only CTO/lead engineers have access to core DBs and migrations.
- All other devs have read/write access only to their own data (via API or DB roles).
- Secrets are managed via environment variables and cloud secrets managers.
- All DB access and changes are logged and auditable.
- All code must be modular, DRY, type-safe, and serverless/stateless.
- All onboarding, setup, and maintenance is automated and documented.
EOF

# 9. Example docs
cat <<EOF > docs/database.md
# Database Design & Management

## Overview

- Uses Drizzle ORM for schema, migrations, and seeding.
- Neon (Postgres) for relational data.
- Upstash (Redis) for cache/pubsub.
- Timescale for event logging/analytics.

## Local Development

- Start local DBs: \`docker-compose up -d\`
- Run migrations: \`pnpm drizzle-kit migrate:latest\`
- Seed DB: \`pnpm run seed\`
- Reset DB: \`pnpm run reset\`

## Security

- Only CTO/lead engineers have access to core DBs and migrations.
- All other devs have read/write access only to their own data (via API or DB roles).
- Secrets are managed via environment variables and cloud secrets managers.
- All DB access and changes are logged and auditable.

## Migrations

- All migrations are in \`/src/migrations/\`.
- Use Drizzle migration system for all schema changes.

## Seeding

- All seed scripts are in \`/src/seeds/\`.
- Use \`pnpm run seed\` to seed the DB.

## Multi-Tenancy & Region

- All models must include \`tenantId\` and \`region\` fields.
- Data is partitioned by tenant and region for compliance and performance.

## Docs

- See \`/docs/\` for more info.
EOF

# 10. .gitkeep for empty folders
touch src/migrations/.gitkeep
touch src/seeds/.gitkeep
touch src/registry/.gitkeep
touch docs/.gitkeep
touch tests/.gitkeep

# 11. Git add/commit/push
git add .
git commit -m "Added initial Drizzle config, model, migration, seed, registry, docs, rules, and env"
git push

echo "✅ parakademisi-database repo fully scaffolded and pushed."
