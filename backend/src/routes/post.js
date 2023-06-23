const {Router} = require("express")
const {validateFields, validateJWT} = require("../middlewares/validate")
const {addPost, getAllPost} = require("../controllers/posts")
const {check} = require("express-validator")

const router = Router()

router.post("/add", [
    check('content').notEmpty().withMessage("El contenido no debe estar vacío"),
    validateFields,
    validateJWT
], addPost)

router.get("/all", getAllPost)

module.exports = router