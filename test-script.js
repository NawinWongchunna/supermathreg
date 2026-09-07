import http from 'k6/http';
import { check, sleep } from 'k6';

  export const options = {
  stages: [
    { duration: '30s', target: 20 },   // ไต่ขึ้นถึง 20 VUs ใน 30 วิ
    { duration: '1m30s', target: 20 }, // คงที่ 20 VUs ต่อ 1 นาทีครึ่ง
    { duration: '20s', target: 0 },    // ค่อยๆ ลดลงจนหยุด
  ],
};

export default function () {
  const res = http.get('https://supermathreg.vercel.app/');

  console.log(`status: ${res.status}, error: ${res.error}`);

  check(res, {
    'status is 200': (r) => r.status === 200,
  });

  sleep(1);
}