const {request, response} = require("express")
const bcrypt = require("bcrypt")
const {generateJWT} = require("../middlewares/validate")
const {UserModel : User} = require("../models/User")

const SignIn = async (req = request, res = response) => {
    const {email, password} = req.body

    try {
        const user = await User.findOne({email})

        if (!user) {
            res.status(400).json({msg: "Usuario no encontrado.", statusCode: 400})
        }

        const isPassword = bcrypt.compareSync(password, user.password)

        if (!isPassword) {
            res.status(400).json({msg: "La contraseña es incorrecta.", statusCode: 400})
        }

        const token = await generateJWT(user.id)

        res.status(200).json({msg: "Usuario encontrado.", token, statusCode: 200})
    } catch (error) {
        console.log(error)
    }
}

module.exports = {
    SignIn
}