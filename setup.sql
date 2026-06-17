-- วางทั้งหมดนี้ใน SQL Editor ของ Supabase แล้วกด Run

-- ตารางรายการแข่งขัน
CREATE TABLE competitions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  date TEXT,
  description TEXT,
  image_url TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ตารางผู้สมัคร
CREATE TABLE registrations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reg_number TEXT UNIQUE,
  firstname TEXT NOT NULL,
  lastname TEXT NOT NULL,
  school TEXT NOT NULL,
  province TEXT NOT NULL,
  grade TEXT NOT NULL,
  level TEXT,
  competition TEXT NOT NULL,
  coach_name TEXT,
  coach_phone TEXT,
  slip_url TEXT,
  status TEXT DEFAULT 'รอตรวจสอบ',
  receipt_option TEXT DEFAULT 'no',
  institution_name TEXT,
  institution_taxid TEXT,
  institution_province TEXT,
  payer_name TEXT,
  payer_id TEXT,
  payer_address TEXT,
  payer_province TEXT,
  payer_phone TEXT,
  additional_note TEXT,
  remark TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- เพิ่มรายการแข่งขันตัวอย่าง (แก้ชื่อได้ทีหลัง)
INSERT INTO competitions (name, date, description) VALUES
  ('SuperMath ระดับประถม', '20 ก.ย. 2568', 'การแข่งขันคณิตศาสตร์ระดับประถมศึกษา'),
  ('SuperMath ระดับมัธยม', '21 ก.ย. 2568', 'การแข่งขันคณิตศาสตร์ระดับมัธยมศึกษา'),
  ('SuperMath Open', '22 ก.ย. 2568', 'การแข่งขันแบบเปิด ทุกระดับชั้น'),
  ('SuperLaw Challenge', '23 ก.ย. 2568', 'การแข่งขันกฎหมายและตรรกะ');

-- เปิดให้ทุกคนอ่านข้อมูลได้ (Public)
ALTER TABLE competitions ENABLE ROW LEVEL SECURITY;
ALTER TABLE registrations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "อ่านได้ทุกคน" ON competitions FOR SELECT USING (true);
CREATE POLICY "อ่านได้ทุกคน" ON registrations FOR SELECT USING (true);
CREATE POLICY "เพิ่มได้ทุกคน" ON registrations FOR INSERT WITH CHECK (true);
CREATE POLICY "แก้ไขได้ทุกคน" ON registrations FOR UPDATE USING (true);

-- เปิด Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE registrations;
