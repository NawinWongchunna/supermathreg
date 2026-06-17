-- SQL script สำหรับจัดการใบเสร็จ
-- วางทั้งหมดนี้ใน SQL Editor ของ Supabase แล้วกด Run
-- (ใช้เมื่อต้องการอัปเดตโครงสร้างฐานข้อมูลที่มีอยู่แล้ว)

-- เพิ่ม columns ใหม่ในตาราง registrations สำหรับข้อมูลใบเสร็จ (ถ้าไม่มี)
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS receipt_option TEXT DEFAULT 'no';
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS institution_name TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS institution_taxid TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS institution_province TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS payer_name TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS payer_id TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS payer_address TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS payer_province TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS payer_phone TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS coach_name TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS coach_phone TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS additional_note TEXT;
ALTER TABLE registrations ADD COLUMN IF NOT EXISTS remark TEXT;

-- สร้าง table ใหม่สำหรับจัดการใบเสร็จ
CREATE TABLE IF NOT EXISTS receipts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reg_number TEXT NOT NULL UNIQUE,
  institution_name TEXT NOT NULL,
  institution_taxid TEXT,
  institution_province TEXT,
  payer_name TEXT NOT NULL,
  payer_id TEXT,
  payer_address TEXT,
  payer_province TEXT,
  payer_phone TEXT,
  receipt_issued BOOLEAN DEFAULT false,
  issued_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- เปิด Row Level Security
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

-- เพิ่ม Policies สำหรับ receipts
CREATE POLICY IF NOT EXISTS "อ่านได้ทุกคน" ON receipts FOR SELECT USING (true);
CREATE POLICY IF NOT EXISTS "เพิ่มได้ทุกคน" ON receipts FOR INSERT WITH CHECK (true);
CREATE POLICY IF NOT EXISTS "แก้ไขได้ทุกคน" ON receipts FOR UPDATE USING (true);

-- เปิด Realtime สำหรับ receipts
ALTER PUBLICATION supabase_realtime ADD TABLE IF NOT EXISTS receipts;

