module.exports = () => {
const express = require("express");
const bodyParser = require("body-parser");
const dotenv = require("dotenv");

dotenv.config();
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  return res.send("<h1>Hello World</h1>");
});

require("./routes/index")(app);

app.get("*", (req, res) => {
  return res.status(404).send("<h1>Error 404 Not found</h1>");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`
      ***************************
            Sever Run Succeed
            Port: ${PORT}
      ***************************
`)
});
}