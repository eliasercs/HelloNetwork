const express = require("express")
const connect = require("../database/config")
require("dotenv").config()

class Server {
    port = process.env.PORT || 4000
    uri_db = process.env.MONGODB_CNN

    constructor() {
        this.app = express()
        this.connect_db()
        this.midlewares()
        this.routes()
    }

    async connect_db() {
        await connect(this.uri_db)
    }

    midlewares () {
        this.app.use(express.json())
    }

    routes() {
        this.app.use("/api/users", require("../routes/user"))
        this.app.use("/api/auth", require("../routes/auth"))
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`Aplicación ejecutando en el puerto ${this.port}`)
        })
    }
}

module.exports = Server