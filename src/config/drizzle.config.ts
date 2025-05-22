import { defineConfig } from "drizzle-kit";
export default defineConfig({
  schema: "./src/models/*.ts",
  out: "./src/migrations",
  driver: "pg",
  dbCredentials: {
    connectionString: process.env.DATABASE_URL || "",
  },
});
