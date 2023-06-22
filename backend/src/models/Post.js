const {Schema, model} = require("mongoose")
const {UserSchema} = require("./User")
const {CommentSchema} = require("./Comment")

const PostSchema = Schema({
    author: {type: UserSchema, required: [true]},
    datetime: {type: Date},
    content: {type: String, required: [true]},
    n_reactions: {type: Number, default: 0},
    comments: {type: [CommentSchema]}
})

const PostModel = model("Post", PostSchema)

module.exports = {PostModel, PostSchema}