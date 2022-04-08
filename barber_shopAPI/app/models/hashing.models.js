const { genSaltSync, hashSync, compareSync } = require('bcrypt')

function hashPassword(password) {
  const salt = genSaltSync(10)
  return hashSync(password, salt)
}

function verifyingHash(password, passwordDB) {
  return compareSync(password, passwordDB)
}

module.exports = { hashPassword, verifyingHash }
