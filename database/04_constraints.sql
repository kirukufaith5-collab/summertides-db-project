-- =====================================================================
-- File:    04_constraints.sql
-- Topic:   Constraints & Performance Indexes (QA FIXED)
-- Owner:   Brigit Njoroge / Fixed by QA Tester
-- Engine:  SQLite3
-- =====================================================================

PRAGMA foreign_keys = ON;

-- Enforce uniqueness on the sponsor's name instead of a nonexistent email
CREATE UNIQUE INDEX IF NOT EXISTS uq_sponsor_name
    ON sponsors(sponsor_name);

-- Performance Indexes (Removed the nonexistent sales attendee relationship)
CREATE INDEX IF NOT EXISTS idx_sales_vendor          ON sales(vendor_id);
CREATE INDEX IF NOT EXISTS idx_tickets_attendee        ON tickets(attendee_id);
CREATE INDEX IF NOT EXISTS idx_performances_artist     ON performances(artist_id);
CREATE INDEX IF NOT EXISTS idx_performances_stage      ON performances(stage_id);
CREATE INDEX IF NOT EXISTS idx_sponsorships_stage      ON stage_sponsorships(stage_id);
CREATE INDEX IF NOT EXISTS idx_sponsorships_sponsor    ON stage_sponsorships(sponsor_id);

-- Datetime Performance Indexes (Fixed column name to sale_time)
CREATE INDEX IF NOT EXISTS idx_performances_time ON performances(start_time, end_time);
CREATE INDEX IF NOT EXISTS idx_sales_time        ON sales(sale_time);

-- Verify every index above was created successfully.
SELECT name, tbl_name
FROM sqlite_master
WHERE type = 'index' AND sql IS NOT NULL
ORDER BY tbl_name, name;