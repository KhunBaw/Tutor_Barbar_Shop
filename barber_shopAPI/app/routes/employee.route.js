module.exports = (app) => {
  const router = require('express').Router()
  const { verifytoken } = require('../models/middleware.models.js')
  const { create,findAll,findOne,update,deleteOne,login,number } = require('../controllers/employee.controller')

  router.post('/', create)

  router.get('/',verifytoken,findAll)

  router.post('/login',login)

  router.get('/getone',verifytoken, findOne)

  router.post('/number',number)

  router.put('/:id', update)

  router.delete('/:id', deleteOne)

  //เซ็ต PREFIX
  app.use(process.env.PREFIX + '/employee', router)
}
