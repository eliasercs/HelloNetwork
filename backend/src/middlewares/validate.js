const {request, response} = require("express")
const {validationResult} = require("express-validator")
const jwt = require("jsonwebtoken")
const User = require("../models/User")

const validateFields = (req = request, res = response, next) => {
    const error = validationResult(req)

    if (!error.isEmpty()) {
        res.status(400).json(error)
    }

    next()
}

const generateJWT = (uid = "") => {
    return jwt.sign({ uid }, process.env.SECRET_KEY)
}

const validateJWT = async (req = request, res = response, next) => {
    const token = req.header("auth-token")
    const key = process.env.SECRET_KEY
    
    if (!token) {
        res.status(401).send("No existe Token de Autenticación.")
    }

    try {
        const payload = jwt.verify(token, key)
        const user = await User.findById(payload.uid)
        req.id = payload.uid
        req.user = user
        next()
    } catch (error) {
        console.log(error)
        res.status(401).send("Token no válido.")
    }
}

module.exports = {
    generateJWT,
    validateFields,
    validateJWT
}