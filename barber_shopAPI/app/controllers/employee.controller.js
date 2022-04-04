const validate_req = require('../models/validate_request')
const mysql = require('../models/mysql.models')

exports.create = (req, res) => {
  //ดึงข้อมูลจาก request
  const { username, password, fname, lname } = req.body
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [username, password, fname])) return
  //คำสั่ง SQL
  let sql = `INSERT INTO employee SET ?`
  //ข้อมูลที่จะใส่ ชื่อฟิล : ข้อมูล
  let data = {
    username: username,
    password: password,
    emp_fname: fname,
    emp_lname: lname,
  }
  //เพิ่มข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  mysql.create(sql, data, (err, data) => {
    if ((err.errno = 1062)) {
      return res.status(400).json({
        message: 'Username already have',
      })
    }

    if (err)
      res.status(500).send({
        message: err.message || 'Some error occurred.',
      })
    else res.status(201).json(data)
  })
}

exports.findAll = (req, res) => {
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  mysql.get(sql, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else if (data) res.status(200).json(data)
    else res.status(204).end()
  })
}

exports.findOne = (req, res) => {
  //ดึงข้อมูลจาก params
  const { id } = req.params
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee WHERE emp_id = ${id}`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  mysql.get(sql, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else if (data[0]) res.status(200).json(data[0])
    else res.status(204).end()
  })
}

exports.update = (req, res) => {
  //ดึงข้อมูลจาก request
  const { fname, lname } = req.body
  //ดึงข้อมูลจาก params
  const { id } = req.params
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [fname, id])) return
  //คำสั่ง SQL
  let sql = `UPDATE employee SET emp_fname = ?,emp_lname  = ? WHERE emp_id = ?`
  //ข้อมูลที่จะแก้ไขโดยเรียงตามลำดับ เครื่องหมาย ?
  let data = [fname, lname, id]
  //แก้ไขข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  mysql.update(sql, data, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else res.status(204).end()
  })
}

exports.delete = (req, res) => {
  //ดึงข้อมูลจาก params
  const { id } = req.params
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `DELETE FROM employee WHERE emp_id = ?`
  //ข้อมูลที่จะแก้ไขโดยเรียงตามลำดับ เครื่องหมาย ?
  let data = [id]
  //ลบข้อมูล โดยส่งคำสั่ง SQL และ id เข้าไป
  mysql.delete(sql, data, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else res.status(204).end()
  })
}
