const multer = require("multer")
const path = require("node:path")

console.log(path.dirname)

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "./src/files/avatar")
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + "_" + Date.now())
    }
})

const upload = multer({storage})

module.exports = upload