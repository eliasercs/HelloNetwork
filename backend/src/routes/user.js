const {Router} = require("express")
const {register, avatar, getAvatar, getUserAuth, getAllUsers, addExperience, addEducationHistory} = require("../controllers/users")
const {validateFields, validateJWT} = require("../middlewares/validate")
const {check} = require("express-validator")
const upload = require("../middlewares/storage")

const router = Router()

router.post("/signup", [
    check("name").notEmpty().withMessage("Debe ingresar un nombre."),
    check("lastname").notEmpty().withMessage("Debe ingresar un apellido."),
    check("email").isEmail().withMessage("Debe ingresar un correo electrónico válido"),
    check("password")
        .notEmpty()
        .withMessage("Debe ingresar una contraseña")
        .isStrongPassword({minUppercase: 1, minLowercase: 1, minSymbols: 1, minNumbers: 1, minLength: 8})
        .withMessage("Debe ingresar una contraseña con mínimo: 8 carácteres, 1 letra en minúscula, 1 letra en mayúscula, 1 símbolo y 1 número."),
    validateFields
], register)

router.post("/avatar", upload.single('avatar'), avatar)
router.get("/get_avatar", validateJWT, getAvatar)
router.get("/user_auth", validateJWT, getUserAuth)
router.get("/all_users", validateJWT, getAllUsers)

router.post("/add_experience",validateJWT, addExperience)
router.post("/add_education", validateJWT, addEducationHistory)

module.exports = router