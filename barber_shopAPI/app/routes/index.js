module.exports = app => {
    //ดึงโค้ดมาเรียกแล้วส่งตัวแปร app ไปด้วย
require("./employee.route")(app);
}