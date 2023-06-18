const express = require("express")
const connect = require("../database/config")
const cors = require("cors")
const { socketController } = require("../sockets/controllers")
require("dotenv").config()

class Server {
    port = process.env.PORT || 4000
    uri_db = process.env.MONGODB_CNN

    constructor() {
        this.app = express()
        this.connect_db()
        this.midlewares()
        this.routes()

        this.server = require("http").createServer(this.app)

        this.io = require("socket.io")(this.server)

        // Sockets
        this.sockets()
    }

    async connect_db() {
        await connect(this.uri_db)
    }

    midlewares () {
        this.app.use(cors())
        this.app.use(express.json())
        this.app.use( express.static("src/public") )
    }

    routes() {
        this.app.use("/api/users", require("../routes/user"))
        this.app.use("/api/auth", require("../routes/auth"))
    }

    sockets() {
        this.io.on("connection", (socket) => socketController(socket, this.io))
    }

    listen() {
        this.server.listen(this.port, () => {
            console.log(`Aplicación ejecutando en el puerto ${this.port}`)
        })
    }
}

module.exports = Server