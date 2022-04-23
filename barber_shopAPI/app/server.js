module.exports = () => {
  const express = require('express')
  const bodyParser = require('body-parser')
  const dotenv = require('dotenv')

  dotenv.config()
  const app = express()
  app.use(express.json())

  //หน้าแรกจะแสดงคำยอดฮิต
  app.get('/', (req, res) => {
    return res.send('<h1>Hello World</h1>')
  })

  //ดึงโค้ดมาเรียกแล้วส่งตัวแปร app ไปด้วย
  require('./routes/index')(app)

  //หน้าใดๆ ก็ตามที่ไม่มีการเรียกก่อนหน้าจะส่ง error 404 พร้อมแสดงคำขนาดใหญ่
  app.get('*', (req, res) => {
    return res.status(404).send('<h1>Error 404 Not found</h1>')
  })

  //เซ็ต port
  const PORT = process.env.PORT || 3000
  app.listen(PORT, () => {
    console.log(`
      ***************************
            Sever Run Succeed
            Port: ${PORT}
      ***************************
`)
  })
}
