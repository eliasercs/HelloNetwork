const Socket = require("socket.io")
const {checkSockets} = require("../middlewares/validate")
const ChatInfo = require("../models/ChatInfo")
const Message = require("../models/Message")
const User = require("../models/User")

const fs = require("node:fs")
const path = require("node:path")

const chat = new ChatInfo()

const socketController = async (socket, io) => {
    const token = socket.handshake.headers["auth-token"]
    const user = await checkSockets(token)

    if (!user) {
        return socket.disconnect()
    }

    // Conectar a una sala especial
    socket.join(user.id)

    // Conectar usuarios
    chat.connectUser( user )
    io.emit("active-users", {data: chat.UsersArr})

    socket.on("active", (payload) => {
        io.emit("active-users", {data: chat.UsersArr})
    })

    // Limpiar cuando un usuario se desconecta
    socket.on("disconnect", () => {
        chat.desconnectUser(user.id)
        io.emit("active-users", {data: chat.UsersArr})
    })

    socket.on("private-message", async (payload) => {
        console.log(payload)
        const {uid, message} = payload

        console.log(`De: ${user.id} Para: ${uid}`)

        const msg = await new Message({content: message, author: user.id, receiver: uid})
        await msg.save()

        socket.to(uid).emit("rescue-messages",uid)
    })

    socket.on("rescue-messages", async (payload) => {
        if (payload !== "") {
            let result1 = await Message.find({author: user.id})
            let result2 = await Message.find({author: payload})
            let another_user = await User.findById(payload)

            let buff = fs.readFileSync(path.normalize(another_user["avatar"]["image"])).toString()
            result2 = result2.map(element => {
                const {content, _id, author, receiver, date, __v} = element
                return {_id, content, author, receiver, date, __v, buff}
            })

            let result = [...result1, ...result2]

            const sortedArray = result.sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
            io.to(user.id).emit("get-messages", sortedArray)
        } else {
            io.to(user.id).emit("get-messages", [])
        }
    })

}

module.exports = {socketController}