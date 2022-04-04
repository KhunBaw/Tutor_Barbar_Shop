module.exports = app => {
  const testCon = require("../controllers/employee.controller");
  const prefix = process.env.PREFIX;
  const router = require("express").Router();

  router.post("/", testCon.create);

  router.get("/", testCon.findAll);

  router.get("/:id", testCon.findOne);

  router.put("/:id", testCon.update);

  router.delete("/:id", testCon.delete);

  app.use(prefix+"/employee", router);
};
