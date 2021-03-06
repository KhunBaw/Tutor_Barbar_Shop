const validate_req = require('../models/validate_req.models')
const mysql = require('../models/mysql.models')
const { verifyingHash, hashPassword } = require('../models/hashing.models')
const { signtoken } = require('../models/middleware.models')

exports.create = async (req, res) => {
  //ดึงข้อมูลจาก request
  const { username, password, fname, lname } = req.body
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [username, password, fname])) return
  //คำสั่ง SQL
  let sql = `INSERT INTO employee SET ?`
  //ข้อมูลที่จะใส่ ชื่อฟิล : ข้อมูล
  let data = {
    username: username,
    password: hashPassword(password),
    emp_fname: fname,
    emp_lname: lname,
  }
  //เพิ่มข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  await mysql.create(sql, data, (err, data) => {
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

exports.findAll = async (req, res) => {
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  await mysql.get(sql, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else if (data) res.status(200).json(data)
    else res.status(204).end()
  })
}

exports.findOne = async (req, res) => {
  //ดึงข้อมูลจาก params
  const { emp_id } = req.authData
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [])) return
  //คำสั่ง SQL
  let sql = `SELECT * FROM employee WHERE emp_id = ${emp_id}`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  await mysql.get(sql, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else if (data[0]) {
      data[0].number = emp_id + 1
      res.status(200).json(data[0])
    }
    else res.status(204).end()
  })
}

exports.update = async (req, res) => {
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
  await mysql.update(sql, data, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else res.status(204).end()
  })
}

exports.deleteOne = async (req, res) => {
  //ดึงข้อมูลจาก params
  const { id } = req.params
  //ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [id])) return
  //คำสั่ง SQL
  let sql = `DELETE FROM employee WHERE emp_id = ?`
  //ข้อมูลที่จะแก้ไขโดยเรียงตามลำดับ เครื่องหมาย ?
  let data = [id]
  //ลบข้อมูล โดยส่งคำสั่ง SQL และ id เข้าไป
  await mysql.delete(sql, data, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else res.status(204).end()
  })
}

exports.login = async (req, res) => {
  const { username, password } = req.body

  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [username, password])) return
  // คำสั่ง SQL
  let sql = `SELECT * FROM employee WHERE username = '${username}'`
  //ดึงข้อมูล โดยส่งคำสั่ง SQL เข้าไป
  await mysql.get(sql, async (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || 'Some error occurred.',
      })
    else if (data[0] && verifyingHash(password, data[0].password))  {
      data[0].token = await signtoken({ emp_id: data[0].emp_id },'1d')
      delete data[0].password
      res.status(200).json(data[0])
    } else res.status(204).end()
  })
}


exports.number =  (req, res) => {
  const { num1, num2 } = req.body
  // ตรวจสอบความถูกต้อง request
  if (validate_req(req, res, [num1, num2])) return

  let number = num1 * num2
  let number2 = parseInt(num1) + parseInt(num2)

  res.status(200).json({
    num1 : number,
    num2 : number2
  })
}