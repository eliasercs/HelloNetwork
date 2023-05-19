const {request, response} = require("express")
const {validationResult} = require("express-validator")
const jwt = require("jsonwebtoken")

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

const validateJWT = (req = request, res = response, next) => {
    const token = req.header("auth-token")
    const key = process.env.SECRET_KEY
    
    if (!token) {
        res.status(401).send("No existe Token de Autenticación.")
    }

    try {
        const payload = jwt.verify(token, key)
        req.id = payload.uid
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