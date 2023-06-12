const express = require("express")
const connect = require("../database/config")
const cors = require("cors")
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
        this.io.on("connection", client => {
            console.log("Cliente conectado ", client.id)
            //client.on("event", data => {})
            
            client.on("send-message", (payload) => {
                console.log(payload)
                this.io.emit("send-message", payload)
            })

            client.on("disconnect", () => {
                console.log("Cliente desconectado ", client.id)
            })
        })
    }

    listen() {
        this.server.listen(this.port, () => {
            console.log(`Aplicación ejecutando en el puerto ${this.port}`)
        })
    }
}

module.exports = Server