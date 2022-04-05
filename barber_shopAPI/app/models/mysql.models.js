const db = require('../config/db')

exports.create = async (query, newData, result) => {
  await db.query(query, newData, (error, results, fields) => {
    // error คือ ข้อผิดพลาดของคำสั่ง sql นั้นๆ  if (error) throw error;
    // results เป็น array ของข้อมูลผลลัพธ์
    // fields เป็นรายละเอียดของฟิลด์ของตาราง tbl_users ปกติเราจะไม่ได้ใช้ค่านี้เท่าไหร่

    //หาก error
    if (error) {
      console.log('error: ', error)
      result(error, null)
      return
    }
    result(null, { id: results.insertId, ...newData })
  })
}

exports.get = async (query, result) => {
  await db.query(query, (error, results, fields) => {
    // error คือ ข้อผิดพลาดของคำสั่ง sql นั้นๆ  if (error) throw error;
    // results เป็น array ของข้อมูลผลลัพธ์
    // fields เป็นรายละเอียดของฟิลด์ของตาราง tbl_users ปกติเราจะไม่ได้ใช้ค่านี้เท่าไหร่

    //หาก error
    if (error) {
      //แจ้งสถานะ error
      console.log('error: ', error)
      //สถานะ 500 ข้อความแสดงความผิดพลาดแบบทั่วไป ใช้เมื่อไม่มีข้อความเฉพาะที่เหมาะสมในการแจ้งสาเหตุ
      result({ status: 500, message: error }, null)
      return
    }
    result(null, results)
  })
}

exports.update = async (query, newData, result) => {
  await db.query(query, newData, (error, results, fields) => {
    // error คือ ข้อผิดพลาดของคำสั่ง sql นั้นๆ  if (error) throw error;
    // results เป็น array ของข้อมูลผลลัพธ์
    // fields เป็นรายละเอียดของฟิลด์ของตาราง tbl_users ปกติเราจะไม่ได้ใช้ค่านี้เท่าไหร่

    //หาก error
    if (error) {
      //แจ้งสถานะ error
      console.log('error: ', error)
      //สถานะ 500 ข้อความแสดงความผิดพลาดแบบทั่วไป ใช้เมื่อไม่มีข้อความเฉพาะที่เหมาะสมในการแจ้งสาเหตุ
      result({ status: 500, message: error }, null)
      return
    }
    //หากไม่มีการอัพเดท
    if (results.affectedRows == 0) {
      // สถานะ 404 ทรัพยากรที่ร้องขอไม่พบบนเครื่องแม่ข่าย แต่อาจสามารถกลับมามีได้ใหม่ในอนาคต การร้องขออื่น ๆ ที่ตามมายังสามารถดำเนินการได้ต่อไป
      result({ status: 404, message: 'not_found' }, null)
      return
    }

    result(null, { ...results })
  })
}

exports.delete = async (query, newData, result) => {
  await db.query(query, newData, (error, results, fields) => {
    // error คือ ข้อผิดพลาดของคำสั่ง sql นั้นๆ  if (error) throw error;
    // results เป็น array ของข้อมูลผลลัพธ์
    // fields เป็นรายละเอียดของฟิลด์ของตาราง tbl_users ปกติเราจะไม่ได้ใช้ค่านี้เท่าไหร่

    //หาก error
    if (error) {
      //แจ้งสถานะ error
      console.log('error: ', error)
      //สถานะ 500 ข้อความแสดงความผิดพลาดแบบทั่วไป ใช้เมื่อไม่มีข้อความเฉพาะที่เหมาะสมในการแจ้งสาเหตุ
      result({ status: 500, message: error }, null)
      return
    }
    //หากไม่มีการลบ
    if (results.affectedRows == 0) {
      // สถานะ 404 ทรัพยากรที่ร้องขอไม่พบบนเครื่องแม่ข่าย แต่อาจสามารถกลับมามีได้ใหม่ในอนาคต การร้องขออื่น ๆ ที่ตามมายังสามารถดำเนินการได้ต่อไป
      result({ status: 404, message: 'not_found' }, null)
      return
    }

    result(null, { ...results })
  })
}
