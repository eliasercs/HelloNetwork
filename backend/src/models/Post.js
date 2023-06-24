const {Schema, model} = require("mongoose")
const {CommentSchema} = require("./Comment")
const { UserSchema } = require("./User")

const PostSchema = Schema({
    author: {type: Schema.Types.ObjectId, ref: "User"},
    datetime: {type: Date},
    content: {type: String, required: [true]},
    n_reactions: {type: Number, default: 0},
    comments: {type: [CommentSchema], default: []}
})

const PostModel = model("Post", PostSchema)

module.exports = {PostModel, PostSchema}