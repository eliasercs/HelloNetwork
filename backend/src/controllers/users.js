const {request, response} = require("express")
const User = require("../models/User")
const bcrypt = require("bcrypt")
const fs = require("node:fs")
const path = require("path")

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

const avatar = async (req = request, res = response, next) => {
    const file = req.file
    const {email} = req.body

    if (!file) {
        const error = new Error("Debes subir un archivo.");
        error.statusCode = 400
        return next(error)
    }

    const img = fs.readFileSync(file.path)
    const encode_img = img.toString('base64')
    // Buffer.from(encode_img, "base64"),
    const final_img = {
        contentType: file.mimetype,
        image: file.path
    }

    await fs.writeFileSync(file.path, encode_img)

    await User.updateOne({email},{avatar: final_img})

    res.json({img: "Avatar almacenado satisfactoriamente."})
}

const getAvatar = async (req = request, res = response) => {
    const {email} = req.query

    const user = await User.findOne({email})

    if(!user) {
        res.status(400).send("Recurso no encontrado");
    }

    const {avatar} = user;

    let buff = fs.readFileSync(path.normalize(avatar.image))
    
    res.status(200).send(buff)
}   

module.exports = {
    register, avatar, getAvatar
}