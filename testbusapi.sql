-- -------------------------------------------------------------
-- TablePlus 6.1.6(570)
--
-- https://tableplus.com/
--
-- Database: testbusapi
-- Generation Time: 2024-11-30 12:54:56.3500
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS route_stops_id_seq;

-- Table Definition
CREATE TABLE "public"."route_stops" (
    "id" int4 NOT NULL DEFAULT nextval('route_stops_id_seq'::regclass),
    "route_id" int4,
    "stop_id" int4,
    "position" int4 NOT NULL,
    "direction" smallint NOT NULL DEFAULT 0,
    "arrival" time NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS routes_id_seq;

-- Table Definition
CREATE TABLE "public"."routes" (
    "id" int4 NOT NULL DEFAULT nextval('routes_id_seq'::regclass),
    "begin_stop_id" int4 NOT NULL,
    "end_stop_id" int4 NOT NULL,
    "name" varchar(255) NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS stops_id_seq;

-- Table Definition
CREATE TABLE "public"."stops" (
    "id" int4 NOT NULL DEFAULT nextval('stops_id_seq'::regclass),
    "name" varchar(255) NOT NULL,
    PRIMARY KEY ("id")
);

ALTER TABLE "public"."route_stops" ADD FOREIGN KEY ("stop_id") REFERENCES "public"."stops"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."route_stops" ADD FOREIGN KEY ("route_id") REFERENCES "public"."routes"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."routes" ADD FOREIGN KEY ("begin_stop_id") REFERENCES "public"."stops"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."routes" ADD FOREIGN KEY ("end_stop_id") REFERENCES "public"."stops"("id") ON DELETE CASCADE ON UPDATE CASCADE;
