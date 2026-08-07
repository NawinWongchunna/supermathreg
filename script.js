import http from 'k6/http';
import { sleep } from 'k6';

// กำหนดเงื่อนไขการทดสอบ (Option)
export const options = {
  stages: [
    { duration: '30s', target: 20 },  // 30 วินาทีแรก: ค่อยๆ เพิ่มคนเป็น 20 คน
    { duration: '1m',  target: 100 }, // 1 นาทีถัดมา: ไต่ระดับเพิ่มคนเป็น 100 คน
    { duration: '30s', target: 0 },   // 30 วินาทีสุดท้าย: ค่อยๆ ลดคนลงเหลือ 0
  ],
};

export default function () {
  // สั่งให้ผู้ใช้เข้าไปที่หน้าเว็บ
  http.get('https://your-website.com'); 
  
  // จำลองให้ผู้ใช้รอ 1 วินาทีก่อนกดหน้าถัดไป
  sleep(1); 
}