const {Schema, model} = require("mongoose")

const ReactionSchema = Schema({
    post: {type: Schema.Types.ObjectId, ref: "Post"},
    users: [{type: Schema.Types.ObjectId, ref: "User"}]
})

const ReactionModel = model("Reaction", ReactionSchema)

module.exports = {ReactionModel, ReactionSchema}