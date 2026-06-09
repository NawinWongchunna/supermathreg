-- รัน SQL นี้ใน Supabase SQL Editor เพิ่มเติมจากเดิม
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS teacher TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS batch_id TEXT;
