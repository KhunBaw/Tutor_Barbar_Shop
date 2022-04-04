module.exports = (req, res, list) => {
  //หากไม่มีข้อมูล
  if (!req.body) {
    //แจ้งสถานะ 400 ข้อความร้องขอที่ส่งมามีความผิดพลาดทางไวยากรณ์ หรือไม่สามารถทำตามการร้องขอนั้นได้
    res.status(400).send({
      message: 'Content can not be empty!',
    })
    return true
  } else if (list) {
    //เช็คแต่ละอันว่ามีข้อมูลหรือไม่
    for (const key in list) {
      if (!list[key]) {
        //แจ้งสถานะ 400 ข้อความร้องขอที่ส่งมามีความผิดพลาดทางไวยากรณ์ หรือไม่สามารถทำตามการร้องขอนั้นได้
        res.status(400).send({
          message: 'The data is null!',
        })
        return true
      }
    }
  }
}
