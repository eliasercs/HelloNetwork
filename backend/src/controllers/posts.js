const {request, response} = require("express")
const {PostModel:Post} = require("../models/Post")
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
    const posts = await Post.find({})

    const data = posts.map((element) => {
        const {_id, author, datetime, content, n_reactions, comments} = element
        const {avatar} = author
        const {image} = avatar
        let buff = fs.readFileSync(path.normalize(image)).toString()

        let data = {_id, author, datetime, content, n_reactions, comments, buff}
        return data
    })

    const sortedArray = data.slice().sort(
        (a, b) => {
            return new Date(b.datetime).getTime() - new Date(a.datetime).getTime()
        }
    )

    res.status(200).json(sortedArray)
}

module.exports = {addPost, getAllPost}