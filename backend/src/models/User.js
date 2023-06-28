const {Schema, model} = require("mongoose")
const {EducationSchema} = require("./Education")
const {WorkExperienceSchema} = require("./WorkExperience")
const path = require("path")

const img_default = path.normalize("./src/files/avatar/default/avatar_default")

const UserSchema = Schema({
    name: {type: String, required: [true, "El nombre es obligatorio."]},
    lastname: {type: String, required: [true, "El apellido es obligatorio."]},
    email: {type: String, required: [true, "El correo electrónico es obligatorio."]},
    password: {type: String, required: [true, "La contraseña es obligatoria."]},
    avatar: {type: Object, default: {contentType: "image/jpeg", image: img_default}}, // Guardar la referencia del archivo en el servidor
    google: {type: Boolean, default: false},
    active: {type: Boolean, default: true},
    description: {type: String, default: ""},
    education: {type: [EducationSchema], default: []},
    jobs: {type: [WorkExperienceSchema], default: []}
})

const UserModel = model("User", UserSchema)

module.exports = {UserModel, UserSchema}