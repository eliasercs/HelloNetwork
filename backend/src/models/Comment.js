const {Schema, model} = require("mongoose")

const CommentSchema = Schema({
    author: {type: String, required: [true]},
    datetime: {type: String, required: [true]},
    comment: {type: String, required: [true]}
})

const CommentModel = model("Comment", CommentSchema)

module.exports = {CommentModel, CommentSchema}