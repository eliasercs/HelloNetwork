const mongoose = require("mongoose")

const connect = async (uri) => {
    try {
        await mongoose.connect(uri)
        console.log("Conexión con base de datos establecida con éxito.")
    } catch (error) {
        console.log(error)
        throw new Error("Error al inicializar conexión con base de datos.")
    }
}

module.exports = connect