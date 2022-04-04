import { sign as _sign, verify as _verify } from 'jsonwebtoken'
const secretkey = process.env.SECRETKEY
const algorithm = 'RS256'

async function sign(data, expires) {
  try {
    return _sign(data, secretkey, {
      algorithm: algorithm,
      expiresIn: expires || '3h',
    })
  } catch (e) {
    return null
  }
}

async function verify(req, res, next) {
  let accessToken = getTokenFrom(req)
  if (!accessToken) return res.status(403).send('notToken')

  try {
    _verify(
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

export default { sign, verify, getTokenFrom }
