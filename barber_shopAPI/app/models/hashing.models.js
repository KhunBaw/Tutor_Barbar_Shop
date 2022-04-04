import { genSaltSync, hashSync, compareSync } from 'bcrypt';

function hashPassword(password) {
  const salt = genSaltSync(10)
  return hashSync(password, salt)
}

function verifyingHash(password,passwordDB) {
    const hash = hashPassword(password);
    return compareSync(passwordDB, hash);
}

export default { hashPassword, verifyingHash }