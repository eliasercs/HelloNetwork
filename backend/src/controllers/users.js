const {request, response} = require("express")
const {UserModel : User} = require("../models/User")
const {WorkExperienceModel : Job} = require("../models/WorkExperience")
const {EducationModel : EducationHistory} = require("../models/Education")
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

    res.status(200).json({img: "Avatar almacenado satisfactoriamente."})
}

const getAvatar = async (req = request, res = response) => {
    const user = req.user

    if(!user) {
        res.status(400).send("Recurso no encontrado");
    }

    const {avatar} = user;

    let buff = fs.readFileSync(path.normalize(avatar.image))
    
    res.status(200).send(buff)
}

const getUserAuth = async (req = request, res = response) => {
    const {name, lastname, email, avatar, description, _id, jobs, education} = req.user

    let buff = fs.readFileSync(path.normalize(avatar.image))

    const user = {_id, name, lastname, email, buff: buff.toString(), image: avatar.contentType, description, jobs, education}

    res.status(200).json(user)
}

const getAllUsers = async (req = request, res = response) => {
    const auth = req.user
    const users = await User.find({})

    const usersFilter = users.filter(value => value.email !== auth.email)
    const data = usersFilter.map((value) => {
        let buff = fs.readFileSync(path.normalize(value.avatar.image))
        let user = {
            name: value.name,
            lastname: value.lastname,
            email: value.email,
            avatar: buff.toString()
        }
        return user
    })

    res.status(200).json({"data" : data})
}

const addExperience = async (req = request, res = response) => {
    const user = req.user
    const {date_start, date_end, place, position} = req.body
    const job = new Job({date_start, date_end, place, position})
    await user.jobs.push(job)
    await user.save()

    const {name, lastname, email, avatar, description, _id, jobs, education} = user
    let buff = fs.readFileSync(path.normalize(avatar.image))
    const data = {_id, name, lastname,email, buff: buff.toString(), image: avatar.contentType, description, jobs, education}

    res.status(200).json({msg: "Experiencia Laboral agregada satisfactoriamente.", user: data})
}

const addEducationHistory = async (req = request, res = response) => {
    const user = req.user
    const {date_start, date_end, place, position} = req.body
    const history = await new EducationHistory({date_start, date_end, place, position})
    await user.education.push(history)
    await user.save()

    const {name, lastname, email,  avatar, description, _id, jobs, education} = user
    let buff = fs.readFileSync(path.normalize(avatar.image))
    const data = {_id, name, lastname, email, buff: buff.toString(), image: avatar.contentType, description, jobs, education}
    res.status(200).json({msg: "Historial Académico agregado satisfactoriamente.", user: data})
}

const updateDescription = async (req = request, res = response) => {
    const user = req.user

    const {description} = req.body

    user.description = description
    await user.save()

    const {name, lastname, email, avatar, description:des, _id, jobs, education} = user
    let buff = fs.readFileSync(path.normalize(avatar.image))
    const data = {_id, name, lastname, email, buff: buff.toString(), image: avatar.contentType, description: des, jobs, education}
    res.status(200).json({msg: "Descripción actualizada satisfactoriamente.", user: data})
}

module.exports = {
    register, avatar, getAvatar, getUserAuth, getAllUsers, addExperience, addEducationHistory, updateDescription
}