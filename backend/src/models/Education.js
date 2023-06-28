const {Schema, model} = require("mongoose")

const EducationSchema = Schema({
    date_start: {type: Date},
    date_end: {type: Date},
    place: String,
    position: {type: String, default: "Estudiante"}
})

const EducationModel = model("Education", EducationSchema)

module.exports = {EducationModel, EducationSchema}