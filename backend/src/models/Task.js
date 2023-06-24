const {Schema, model} = require("mongoose")
const {UserSchema} = require("./User")

const TaskSchema = Schema({
    title: {type: String, required: [true]},
    author: {type: String, required: [true]},
    date: {type: String},
    description: {type: String, required: [true]},
    status: {type: String, required: [true]},
    sprint_id: {type: String, default: undefined},
    users: [{type: UserSchema, ref: "User", default: undefined}]
})

module.exports = model("Task", TaskSchema)