const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const app = express();
require('dotenv').config();

app.use(cors());
app.use(express.json());

// 建立資料庫連線
const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE
};

let db;

(async () => {
    try {
        db = await mysql.createConnection(dbConfig);
        console.log('資料庫已成功連線！');
    } catch (err) {
        console.error('資料庫連線失敗：', err);
        process.exit(1);
    }
})();

// 查詢 Reservations 表的資料
app.get('/reservations', async (req, res) => {
    const sql = `
        SELECT r.reservation_id, s.student_name, st.row_label, st.seat_number, t.start_time, t.end_time
        FROM Reservations r
        JOIN Students s ON r.student_id = s.student_id
        JOIN Seats st ON r.seat_id = st.seat_id
        JOIN Timeslots t ON r.timeslot_id = t.timeslot_id;
    `;

    try {
        const [results] = await db.query(sql);
        res.json(results);
    } catch (err) {
        console.error('查詢錯誤：', err);
        res.status(500).send('伺服器錯誤');
    }
});

// 啟動伺服器
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`伺服器正在本地端的 http://localhost:${PORT} 運行`);
});