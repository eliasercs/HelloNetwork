const {request, response} = require("express")
const {PostModel:Post} = require("../models/Post")
const {UserModel : User} = require("../models/User")
const fs = require("node:fs")
const path = require("node:path")

const addPost = async (req = request, res = response) => {
    const user = req.user
    const {date, content} = req.body

    const newPost = await new Post({author: user, datetime: Date.parse(date), content, comments: []})
    await newPost.save()

    res.status(200).json({msg: "Publicación creada satisfactoriamente."})
}

const getAllPost = async (req = request, res = response) => {
    const posts = await Post.find({}).populate("author")


    const data = await posts.map(element => {
        const {_id, author, content, datetime, n_reactions, comments} = element

        const {avatar, _id:id, name, lastname, email, description, education, jobs} = author
        const {image} = avatar
        let buff = fs.readFileSync(path.normalize(image)).toString()

        const a = {_id: id, name, lastname, email, description, education, jobs, buff}

        const p = {_id, content, datetime, n_reactions, comments, buff, author:a}
        return p
    })

    const sortedArray = await data.slice().sort(
        (a, b) => {
            return new Date(b.datetime).getTime() - new Date(a.datetime).getTime()
        }
    )

    res.status(200).json(sortedArray)
}

module.exports = {addPost, getAllPost}