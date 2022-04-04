const validate_req = require("../models/validate_request");
const mysql = require("../models/mysql.models");

exports.create = (req, res) => {
  //Get request
  const { username, password,fname,lname } = req.body
  // Validate request
  if(validate_req(req,res,[username,password,fname])) return;

  let sql = "INSERT INTO employee SET ?";
  let data = {
    username: username,
    password: password,
    emp_fname: fname,
    emp_lname: lname,
  };
  mysql.create(sql, data, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    else res.status(200).json(data);
  });

};

exports.findAll = (req, res) => {
  let sql = "SELECT * FROM employee";

  mysql.get(sql, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    else res.status(200).json(data);
  });
};

exports.findOne = (req, res) => {
  return res.send({ message: "findOne" });
};

exports.update = (req, res) => {
  // Validate request
  validate_req(req);

  return res.send({ message: "update" });
};

exports.delete = (req, res) => {
  return res.send({ message: "delete" });
};

exports.deleteAll = (req, res) => {
  return res.send({ message: "deleteAll" });
};
