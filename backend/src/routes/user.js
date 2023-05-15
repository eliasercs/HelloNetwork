const {Router} = require("express")
const {register} = require("../controllers/users")

const router = Router()

router.post("/signup", register)

module.exports = router