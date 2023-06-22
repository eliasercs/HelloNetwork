const {Router} = require("express")
const {validateFields, validateJWT} = require("../middlewares/validate")
const {addPost} = require("../controllers/posts")
const {check} = require("express-validator")

const router = Router()

router.post("/add", [
    validateJWT], addPost)

module.exports = router