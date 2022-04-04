const db = require("../config/db");

exports.create = (query, newData, result) => {
  db.query(query, newData, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }
    result(null, { id: res.insertId, ...newData });
  });
};

exports.get = (query, result) => {
  db.query(query, (error, results, fields) => {
    // error คือ ข้อผิดพลาดของคำสั่ง sql นั้นๆ  if (error) throw error;
    // results เป็น array ของข้อมูลผลลัพธ์
    // fields เป็นรายละเอียดของฟิลด์ของตาราง tbl_users ปกติเราจะไม่ได้ใช้ค่านี้เท่าไหร่
    if (error) {
      console.log("error: ", error);
      result(null, error);
      return;
    }
    result(null, results);
  });
};
