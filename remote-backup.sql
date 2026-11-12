PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE IF NOT EXISTS "d1_migrations"(
		id         INTEGER PRIMARY KEY AUTOINCREMENT,
		name       TEXT UNIQUE,
		applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(1,'0000_sticky_arachne.sql','2026-11-04 21:40:39');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(2,'0001_silky_sabretooth.sql','2026-11-04 21:40:39');
INSERT INTO "d1_migrations" ("id","name","applied_at") VALUES(3,'0002_curly_wendell_rand.sql','2026-11-04 21:40:39');
CREATE TABLE `projects` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`description` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
);
INSERT INTO "projects" ("id","name","description","created_at","updated_at") VALUES(1,'New Project','Hello There','2026-11-04T21:49:31.802Z','2026-11-04T21:49:31.802Z');
INSERT INTO "projects" ("id","name","description","created_at","updated_at") VALUES(3,'Grading assignment','Instructor evaluation','2026-11-11T05:43:04.498Z','2026-11-11T05:43:04.498Z');
CREATE TABLE `tasks` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`project_id` integer NOT NULL,
	`title` text NOT NULL,
	`description` text DEFAULT '' NOT NULL,
	`status` text DEFAULT 'todo' NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE cascade,
	CONSTRAINT "tasks_status_check" CHECK("tasks"."status" IN ('todo', 'in_progress', 'done'))
);
INSERT INTO "tasks" ("id","project_id","title","description","status","created_at","updated_at") VALUES(1,1,'New Task','New Task Description','todo','2026-11-04T21:51:28.193Z','2026-11-04T21:51:28.193Z');
INSERT INTO "tasks" ("id","project_id","title","description","status","created_at","updated_at") VALUES(3,3,'Grading assignment','','todo','2026-11-11T05:43:04.696Z','2026-11-11T05:43:04.696Z');
CREATE TABLE `users` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`email` text NOT NULL,
	`password_hash` text NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
);
INSERT INTO "users" ("id","email","password_hash","created_at","updated_at") VALUES(1,'hello@there.come','$2b$10$hVLx1H4XukGhucTkqNWuy.C0fi.z1/xTSKV96q5UHcqWgLgVQON5K','2026-11-04T21:48:07.121Z','2026-11-04T21:48:07.121Z');
INSERT INTO "users" ("id","email","password_hash","created_at","updated_at") VALUES(2,'rodolfo@roman.com','$2b$10$c3M7HEkBZoELpuSdMyf00euQIxazafkdc85Da5PKz5C5LQ7jBJPbC','2026-11-11T05:42:37.973Z','2026-11-11T05:42:37.973Z');
CREATE TABLE `sessions` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`user_id` integer NOT NULL,
	`token_hash` text NOT NULL,
	`expires_at` text NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE cascade
);
INSERT INTO "sessions" ("id","user_id","token_hash","expires_at","created_at") VALUES(1,1,'605e2d9395c2b7004d640d41f370b0bb2a900bdf3119a84ad5fe2105570af9a0','2026-11-11T21:48:21.809Z','2026-11-04T21:48:21.809Z');
INSERT INTO "sessions" ("id","user_id","token_hash","expires_at","created_at") VALUES(3,2,'f73a2f03bb08e0804ffe7a839eb854aad5c2bb31188cfde05c2469f2132421dd','2026-11-18T05:42:39.093Z','2026-11-11T05:42:39.093Z');
INSERT INTO "sessions" ("id","user_id","token_hash","expires_at","created_at") VALUES(4,2,'2c7dde4f91414806d92d81eac29b831431806acde9ba9a57dd3c5352fa03dfca','2026-11-18T05:42:47.177Z','2026-11-11T05:42:47.177Z');
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('d1_migrations',3);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('users',2);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('sessions',5);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('projects',3);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('tasks',3);
CREATE INDEX `idx_tasks_project_id` ON `tasks` (`project_id`);
CREATE UNIQUE INDEX `users_email_unique` ON `users` (`email`);
CREATE UNIQUE INDEX `idx_users_email` ON `users` (`email`);
CREATE UNIQUE INDEX `sessions_token_hash_unique` ON `sessions` (`token_hash`);
CREATE UNIQUE INDEX `idx_sessions_token_hash` ON `sessions` (`token_hash`);
CREATE INDEX `idx_sessions_user_id` ON `sessions` (`user_id`);
