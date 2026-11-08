CREATE TABLE "letterhead_logos" (
	"sha256" text PRIMARY KEY NOT NULL,
	"logo" "bytea" NOT NULL,
	"format" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "letterhead_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_default" boolean DEFAULT false NOT NULL,
	"settings" jsonb NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "letterhead_profiles_accent" CHECK ("letterhead_profiles"."settings" ->> 'accent' ~ '^#[0-9A-Fa-f]{6}$')
);
--> statement-breakpoint
ALTER TABLE "invoices" ADD COLUMN "design" jsonb;--> statement-breakpoint
ALTER TABLE "quotes" ADD COLUMN "design" jsonb;--> statement-breakpoint
CREATE UNIQUE INDEX "letterhead_profiles_default" ON "letterhead_profiles" USING btree ("is_default") WHERE "letterhead_profiles"."is_default";