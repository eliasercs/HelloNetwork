const fs = require("node:fs")
const path = require("node:path")

class Message {
    constructor(uid, name, message, author, receiver) {
        this.uid = uid
        this.name = name
        this.message = message
        this.author = author
        this.receiver = receiver
    }
}

class ChatInfo {
    constructor() {
        this.messages = []
        this.users = {}
    }

    get UsersArr() {
        return Object.values(this.users)
    }

    sendMessage(uid, name, message, author, receiver) {
        this.messages.unshift(new Message(uid, name, message, author, receiver))
    }

    connectUser(user) {
        const {id, name, lastname, email, avatar} = user
        const {image} = avatar
        const buff = fs.readFileSync(path.normalize(image)).toString()
        const data = {id, name, lastname, email, avatar: buff}
        this.users[id] = data
    }

    desconnectUser(id) {
        delete this.users[id]
    }
}

module.exports = ChatInfo