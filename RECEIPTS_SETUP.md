# 📋 ตั้งค่าระบบใบเสร็จ

## 📌 ขั้นตอนการตั้งค่า

### 1️⃣ อัปเดตฐานข้อมูล Supabase

คุณต้องรัน SQL script เพื่ออัปเดตตารางและเพิ่ม columns ใหม่:

#### **ตัวเลือก A: ตั้งค่าใหม่จากเริ่มต้น**
- เปิด Supabase SQL Editor
- คัดลอกโค้ดทั้งหมดจากไฟล์ `setup.sql` ของโปรเจกต์นี้
- วางลงใน Supabase SQL Editor
- กด **Run** ✅

#### **ตัวเลือก B: อัปเดตฐานข้อมูลที่มีอยู่แล้ว**
- เปิด Supabase SQL Editor
- คัดลอกโค้ดทั้งหมดจากไฟล์ `receipts.sql` ของโปรเจกต์นี้
- วางลงใน Supabase SQL Editor
- กด **Run** ✅

---

## 🗄️ ตารางฐานข้อมูลใหม่

### **ตาราง: registrations** (อัปเดต)
เพิ่ม columns ใหม่สำหรับจัดการใบเสร็จ:

| Column | Type | คำอธิบาย |
|--------|------|---------|
| receipt_option | TEXT | 'yes' หรือ 'no' |
| institution_name | TEXT | ชื่อหน่วยงาน/สถาบัน |
| institution_taxid | TEXT | รหัสประจำตัวสถานศึกษา |
| institution_province | TEXT | จังหวัดของสถาบัน |
| payer_name | TEXT | ชื่อผู้ชำระเงิน |
| payer_id | TEXT | เลขประจำตัวประชาชน/ทะเบียนการค้า |
| payer_address | TEXT | ที่อยู่ผู้ชำระเงิน |
| payer_province | TEXT | จังหวัดผู้ชำระ |
| payer_phone | TEXT | เบอร์โทรศัพท์ผู้ชำระ |
| coach_name | TEXT | ชื่อผู้ติดต่อ |
| coach_phone | TEXT | เบอร์โทรผู้ติดต่อ |
| additional_note | TEXT | หมายเหตุเพิ่มเติม |
| remark | TEXT | หมายเหตุจากแอดมิน |

### **ตาราง: receipts** (ใหม่)
ตารางสำหรับบันทึกข้อมูลใบเสร็จแยกต่างหาก:

| Column | Type | คำอธิบาย |
|--------|------|---------|
| id | UUID | ID อัตโนมัติ |
| reg_number | TEXT | เลขสมัคร (UNIQUE) |
| institution_name | TEXT | ชื่อหน่วยงาน * |
| institution_taxid | TEXT | รหัสประจำตัวสถานศึกษา |
| institution_province | TEXT | จังหวัด |
| payer_name | TEXT | ชื่อผู้ชำระเงิน * |
| payer_id | TEXT | เลขประจำตัว |
| payer_address | TEXT | ที่อยู่ |
| payer_province | TEXT | จังหวัด |
| payer_phone | TEXT | เบอร์โทร |
| receipt_issued | BOOLEAN | ออกใบเสร็จแล้ว? |
| issued_at | TIMESTAMPTZ | วันที่ออกใบเสร็จ |
| notes | TEXT | หมายเหตุ |

---

## 🔧 การใช้งาน

### ผู้สมัคร:
1. เมื่อเลือก "ต้องการออกใบเสร็จ" → Modal เด้งขึ้น
2. กรอกข้อมูล:
   - **หน่วยงาน/สถาบัน:** ชื่อ + รหัสประจำตัว + จังหวัด
   - **ผู้ชำระเงิน:** ชื่อ + เลขประจำตัว + ที่อยู่ + จังหวัด + เบอร์โทร
3. กด "ยืนยัน" → ข้อมูลเก็บลงในทั้ง registrations และ receipts

### ผู้ดูแลระบบ:
1. เข้า Supabase SQL Editor
2. ตรวจสอบข้อมูลใบเสร็จ:
```sql
SELECT * FROM receipts WHERE receipt_issued = false;
```

3. เมื่อออกใบเสร็จแล้ว:
```sql
UPDATE receipts 
SET receipt_issued = true, issued_at = now() 
WHERE reg_number = 'SML25690001';
```

---

## 📊 Realtime Sync
ทั้งสอง table เปิดใช้ Realtime ดังนั้น:
- ข้อมูลใบเสร็จจะอัปเดตแบบ real-time
- ผู้ใช้อื่นจะเห็นการเปลี่ยนแปลงทันที

---

## ✅ ตรวจสอบการตั้งค่า

เมื่อตั้งค่าเสร็จ ให้ทำการทดสอบ:

1. ไปหน้าสมัครแข่งขัน
2. ทำการสมัครกับตัวเลือก "ต้องการออกใบเสร็จ"
3. กรอกข้อมูลใบเสร็จ
4. ส่งข้อมูลและตรวจสอบใน Supabase ว่าข้อมูลถูกบันทึกใน receipts table

---

💡 **หมายเหตุ:** ถ้าเลือก "ไม่ต้องการใบเสร็จ" ข้อมูลใบเสร็จจะไม่ถูกบันทึก แต่ข้อมูลพื้นฐานจะถูกบันทึกใน registrations อยู่ดี
