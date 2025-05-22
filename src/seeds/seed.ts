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
