const {Schema, model} = require("mongoose")

const PostSchema = Schema({
    author: {type: Schema.Types.ObjectId, ref: "User"},
    datetime: {type: Date},
    content: {type: String, required: [true]},
})

const PostModel = model("Post", PostSchema)

module.exports = {PostModel, PostSchema}