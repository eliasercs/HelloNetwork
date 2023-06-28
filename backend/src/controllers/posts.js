const {request, response} = require("express")
const {PostModel:Post} = require("../models/Post")
const {UserModel : User} = require("../models/User")
const {CommentModel : Comment} = require("../models/Comment")
const {ReactionModel : Reaction} = require("../models/Reaction")
const fs = require("node:fs")
const path = require("node:path")

const addPost = async (req = request, res = response) => {
    const user = req.user
    const {date, content} = req.body

    const newPost = await new Post({author: user, datetime: Date.parse(date), content})
    await newPost.save()

    const newReaction = await new Reaction({post: newPost["_id"], users: []})
    await newReaction.save()
    
    res.status(200).json({msg: "Publicación creada satisfactoriamente."})
}

const getAllPost = async (req = request, res = response) => {
    const posts = await Post.find({}).populate("author")

    const data = await posts.map(element => {
        const {_id, author, content, datetime} = element

        const {avatar, _id:id, name, lastname, email, description, education, jobs} = author
        const {image} = avatar
        let buff = fs.readFileSync(path.normalize(image)).toString()

        const a = {_id: id, name, lastname, email, description, education, jobs, buff}

        const p = {_id, content, datetime, buff, author:a}
        return p
    })

    const sortedArray = await data.slice().sort(
        (a, b) => {
            return new Date(b.datetime).getTime() - new Date(a.datetime).getTime()
        }
    )

    res.status(200).json(sortedArray)
}

const addComment = async (req = request, res = response) => {
    const user = req.user
    const {id_post, content, datetime} = req.body

    const newComment = await new Comment({author: user["_id"], post: id_post, comment: content, datetime})
    await newComment.save()

    res.status(200).json({msg: "Comentario agregado satisfactoriamente."})
}

const countReactionsAndComments = async (req = request, res = response) => {
    const {id_post} = req.query

    const {users} = await Reaction.findOne({post: id_post})
    const comments = await Comment.find({post: id_post})

    res.status(200).json({reactions: users.length, comments: comments.length})
}

const addReaction = async (req = request, res = response) => {
    const {_id: id_user} = req.user
    const {id_post} = req.body

    const reactions = await Reaction.findOne({post: id_post})
    const {users} = reactions

    if (!users.includes(id_user)) {
        await reactions.users.push(id_user)
        await reactions.save()
        res.status(200).json({msg: "Reacción agragada satisfactoriamente", reaction: false})
    } else {
        await reactions.users.pop(id_user)
        await reactions.save()
        res.status(200).json({msg: "Reacción eliminada satisfactoriamente", reaction: true})
    }
}

const getComments = async (req = request, res = response) => {
    const {id_post} = req.query
    const comments = await Comment.find({post: id_post}).populate("author")

    const data = await comments.map(element => {
        const {author, datetime, comment} = element
        const {avatar, name, lastname, email, _id: id} = author
        let buff = fs.readFileSync(path.normalize(avatar["image"])).toString()
        let user = {_id: id, name, lastname, email, buff}
        return {user, datetime, comment}
    })

    res.status(200).json(data)
}

module.exports = {addPost, getAllPost, addComment, addReaction, countReactionsAndComments, getComments}