const mysql = require('mysql') // เรียกใช้งาน MySQL module

// กำหนดการเชื่อมต่อฐานข้อมูล
const db = mysql.createConnection({
  //ip ของ sql
  host: process.env.DB_HOST,
  // port ของ sql
  port: process.env.DB_PORT,
  //username ของ sql
  user: process.env.DB_USER,
  //password ของ sql
  password: process.env.DB_PASSWORD,
  //ชื่อ data ของ sql
  database: process.env.DB_DATABASE,
})

// ทำการเชื่อมต่อกับฐานข้อมูล
db.connect((err) => {
  if (err) {
    // กรณีเกิด error
    console.error('error connecting: ' + err.stack)
    return
  }
  // console.log('connected db as id ' + db.threadId)
})
// ปิดการเชื่อมต่อฐานข้อมูล MySQL ในที่นี้เราจะไม่ให้ทำงาน
// db.end()
module.exports = db
