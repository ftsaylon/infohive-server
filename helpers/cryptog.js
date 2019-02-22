var crypto = require('crypto'),
  algorithm = 'aes-256-gcm',
  password = '3zTvzr3p67VC61jmV54rIYu1545x4TlY',
  // do not use a global iv for production
  // generate a new one for each encryption
  iv = '60iP0h6vJoEa'

exports.encrypt = function(text) {
  try{
    var cipher = crypto.createCipheriv(algorithm, password, iv)
    var encrypted = cipher.update(text, 'utf8', 'hex')
    encrypted += cipher.final('hex');
    var tag = cipher.getAuthTag();
    console.log(encrypted);
    return {
      content: encrypted,
      tag: tag
    };
  }
  catch(err){
    throw err;
  }
}

exports.decrypt = function(encrypted) {
  try{
    // console.log(encrypted);
    var decipher = crypto.createDecipheriv(algorithm, password, iv)
    decipher.setAuthTag(Buffer.from(encrypted.tag.data));
    var dec = decipher.update(encrypted.content, 'hex', 'utf8')
    dec += decipher.final('utf8');
    return dec;
  }
  catch(err){
    throw new Error('DECRYPT_FAILED ' + err.message)
  }
}

