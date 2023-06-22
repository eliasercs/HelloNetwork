const {request, response} = require("express")
const Task = require("../models/Task")

const addNewTask = async (req = request, res = response) => {
    const user = req.user

    const {title, description, status, date, sprint_id, users} = req.body

    let date_task = date
    let sprint = sprint_id
    let users_data = users

    if (!sprint_id) {
        sprint = undefined
    }
    if (!users) {
        users_data = undefined
    }

    const addTask = await new Task({title, author: user, description, status, sprint_id: sprint, users: users_data, date: date_task})
    await addTask.save()

    res.status(200).json({msg: "Tarea creada satisfactoriamente."})
}

const getPersonalTasks = async (req = request, res = response) => {
    const user = req.user

    const planificado = await Task.find({author: user, sprint_id: undefined, status: "Por hacer"})
    const proceso = await Task.find({author: user, sprint_id: undefined, status: "En proceso"})
    const completado = await Task.find({author: user, sprint_id: undefined, status: "Completado"})
    const cancelado = await Task.find({author: user, sprint_id: undefined, status: "Cancelado"})

    const data = {planificado, proceso, completado, cancelado}

    res.status(200).json(data)
}

module.exports = {
    addNewTask,
    getPersonalTasks
}