import { db } from "../src/config/db";
import { user } from "../src/models/user";

test("User table exists", async () => {
  const users = await db.select().from(user);
  expect(Array.isArray(users)).toBe(true);
});
