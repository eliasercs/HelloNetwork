const {Schema, model} = require("mongoose")

const UserSchema = Schema({
    name: {type: String, required: [true, "El nombre es obligatorio."]},
    lastname: {type: String, required: [true, "El apellido es obligatorio."]},
    email: {type: String, required: [true, "El correo electrónico es obligatorio."]},
    password: {type: String, required: [true, "La contraseña es obligatoria."]},
    avatar: {type: String, default: "/default/avatar_user.jpg"}, // Guardar la referencia del archivo en el servidor
    google: {type: Boolean, default: false},
    active: {type: Boolean, default: true},
    description: {type: String, default: ""}
})

module.exports = model("User", UserSchema)