const { sign, verify } = require ('jsonwebtoken');
const secretkey = process.env.SECRETKEY
const algorithm = 'HS384'

exports.signtoken = async(data, expires) => {
  try {
    return await sign(data, secretkey, {
      algorithm: algorithm,
      expiresIn: expires || '3h',
    })
  } catch (e) {
    return null
  }
}

exports.verifytoken = async(req, res, next) => {
  let accessToken = getTokenFrom(req)
  if (!accessToken) return res.status(403).send('notToken')

  try {
    await verify(
      accessToken,
      secretkey,
      { algorithms: [algorithm] },
      (err, authData) => {
        if (err) return res.status(401).send('Token หมดอายุ')
        req.authData = authData
        next()
      }
    )
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