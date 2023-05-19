const {request, response} = require("express")
const bcrypt = require("bcrypt")
const {generateJWT} = require("../middlewares/validate")
const User = require("../models/User")

const SignIn = async (req = request, res = response) => {
    const {email, password} = req.body

    try {
        const user = await User.findOne({email})

        if (!user) {
            res.status(400).send("Usuario no encontrado.")
        }

        const isPassword = bcrypt.compareSync(password, user.password)

        if (!isPassword) {
            res.status(400).send("La contraseña es incorrecta.")
        }

        const token = await generateJWT(user.id)

        res.status(200).send(token)
    } catch (error) {
        console.log(error)
    }
}

module.exports = {
    SignIn
}