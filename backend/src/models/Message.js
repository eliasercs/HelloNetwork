const {Schema, model} = require("mongoose")

// Al aplicar búsquedas, los criterios a utilizar son el autor y el receptor del mensaje
const MessageSchema = Schema({
    content: {type: String},
    author: {type: String}, // ID del autor
    receiver: {type: String}, // ID del receptor
    date: {type: Date, default: Date.now()}
})

module.exports = model("Message", MessageSchema)