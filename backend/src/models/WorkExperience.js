const {Schema, model} = require("mongoose")

const WorkExperienceSchema = Schema({
    date_start: {type: Date},
    date_end: {type: Date},
    place: {type: String},
    position: {type: String}
})

const WorkExperienceModel = model("WorkExperience", WorkExperienceSchema)

module.exports = {WorkExperienceModel, WorkExperienceSchema}