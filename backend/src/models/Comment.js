const {Schema, model} = require("mongoose")

const CommentSchema = Schema({
    author: {type: Schema.Types.ObjectId, ref:"User", required: [true]},
    post: {type: Schema.Types.ObjectId, ref: "Post"},
    datetime: {type: String, required: [true]},
    comment: {type: String, required: [true]}
})

const CommentModel = model("Comment", CommentSchema)

module.exports = {CommentModel, CommentSchema}