const {Schema, model} = require("mongoose")
const {UserSchema} = require("./User")

const CommentSchema = Schema({
    author: {type: UserSchema, required: [true]},
    datetime: {type: String, required: [true]},
    comment: {type: String, required: [true]}
})

const CommentModel = model("Comment", CommentSchema)

module.exports = {CommentModel, CommentSchema}