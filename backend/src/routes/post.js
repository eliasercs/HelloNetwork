const {Router} = require("express")
const {validateFields, validateJWT} = require("../middlewares/validate")
const {addPost, getAllPost, countReactionsAndComments, addComment, addReaction, getComments} = require("../controllers/posts")
const {check} = require("express-validator")

const router = Router()

router.post("/add", [
    check('content').notEmpty().withMessage("El contenido no debe estar vacío"),
    validateFields,
    validateJWT
], addPost)

router.get("/all", getAllPost)
router.get("/count", countReactionsAndComments)

router.post("/add_comment", validateJWT, addComment)
router.post("/add_reaction", validateJWT, addReaction)
router.get("/comments", getComments)

module.exports = router