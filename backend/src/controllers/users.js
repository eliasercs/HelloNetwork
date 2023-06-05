const {request, response} = require("express")
const User = require("../models/User")
const bcrypt = require("bcrypt")

const register = async (req = request, res = response) => {
    const {name, lastname, email, password} = req.body
    console.log(password)

    const user = await User.findOne({email})

    const new_user = new User({
        name, lastname, email, password
    })
    // Verificar la existencia de un usuario con dicho correo electrónico
    if (user) {
        return res.status(400).json({msg: `Ya existe un usuario registrado con el correo electrónico: ${email}`})
    }
    const salt = bcrypt.genSaltSync(10)
    // Encriptar la contraseña
    new_user.password = bcrypt.hashSync(data = password, salt)

    await new_user.save()

    return res.status(200).json({msg: "Usuario registrado satisfactoriamente."})
}

module.exports = {
    register
}