const jwt = require('jsonwebtoken')

async function sign(data) {
  try {
    return await jwt.sign(data, process.env.SECRETKEY, {
      expiresIn: '1d',
    })
  } catch (e) {
    return null
  }
}

async function verify(req, res, next) {
  let accessToken = getTokenFrom(req)
  if (!accessToken) return res.status(403).send('notToken')

  try {
    jwt.verify(accessToken, process.env.SECRETKEY, (err, authData) => {
      if (err) return res.status(401).send('Token หมดอายุ')
      req.authData = authData
      next()
    })
  } catch (e) {
    return res.status(401).end()
  }
}

const getTokenFrom = (request) => {
  const authorization = request.get('Authorization')
  if (authorization && authorization.toLowerCase().startsWith('bearer ')) {
    return authorization.substring(7)
  }
  return null
}

module.exports = { sign, verify, getTokenFrom }
