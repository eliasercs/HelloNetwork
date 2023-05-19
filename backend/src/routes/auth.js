const {Router} = require("express")
const {SignIn} = require("../controllers/auth")
const {validateFields} = require("../middlewares/validate")
const {check} = require("express-validator")

const router = Router()

router.post("/signin", [
    check("email")
        .isEmail()
        .withMessage("Debe ingresar un correo electrónico"),
    check("password")
        .notEmpty()
        .withMessage("Debe ingresar una contraseña")
        .isStrongPassword({minUppercase: 1, minLowercase: 1, minSymbols: 1, minNumbers: 1, minLength: 8})
        .withMessage("Debe ingresar una contraseña con mínimo: 8 carácteres, 1 letra en minúscula, 1 letra en mayúscula, 1 símbolo y 1 número."),
    validateFields
], SignIn)

module.exports = router