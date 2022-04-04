const validate_req = require("../models/validate_request");
const mysql = require("../models/mysql.models");

exports.create = (req, res) => {
  //Get request
  const { username, password, fname, lname } = req.body;
  // Validate request
  if (validate_req(req, res, [username, password, fname])) return;

  let sql = `INSERT INTO employee SET ?`;
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
    else res.status(201).json(data);
  });
};

exports.findAll = (req, res) => {
  let sql = `SELECT * FROM employee`;

  mysql.get(sql, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    else res.status(200).json(data);
  });
};

exports.findOne = (req, res) => {
  //Get params
  const { id } = req.params;
  // Validate request
  if (validate_req(req, res, [id])) return;

  let sql = `SELECT * FROM employee WHERE emp_id = ${id}`;

  mysql.get(sql, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    else res.status(200).json(data[0]);
  });
};

exports.update = (req, res) => {
  //Get request
  const { fname, lname } = req.body;
  //Get params
  const { id } = req.params;
  // Validate request
  if (validate_req(req, res, [fname,id])) return;

  let sql = `UPDATE employee SET emp_fname = ?,emp_lname  = ? WHERE emp_id = ?`;
  let data = [fname, lname,id];
  mysql.update(sql, data, (err, data) => {
    if (err)
    res.status(err.status).send({
      message: err.message || "Some error occurred.",
    });
    else res.status(204).end();
  });
};

exports.delete = (req, res) => {
  //Get params
  const { id } = req.params;
  // Validate request
  if (validate_req(req, res, [id])) return;

  let sql = `DELETE FROM employee WHERE emp_id = ?`;
  let data = [id];
  mysql.delete(sql, data, (err, data) => {
    if (err)
      res.status(err.status).send({
        message: err.message || "Some error occurred.",
      });
    else res.status(204).end();
  });
};
