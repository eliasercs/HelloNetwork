const {request, response} = require("express")
const {PostModel:Post} = require("../models/Post")

const addPost = async (req = request, res = response) => {
    const user = req.user
    const {date, content} = req.body

    const newPost = await new Post({author: user, datetime: Date.parse(date), content, comments: []})
    await newPost.save()

    res.status(200).json({msg: "Publicación creada satisfactoriamente."})
}

module.exports = {addPost}