const socket = io()

const user = {
    name: "Soporte",
    lastname: "Hello Network",
    email: "soporte@hellonetwork.com",
    password: "12345678"
}

document.getElementById("user").innerText = `${user.name} ${user.lastname}`

const sendMessage = document.getElementById("sendMessage")
const messageContainer = document.getElementById("messageContainer")

sendMessage.addEventListener("click", () => {
    const messageInput = document.getElementById("messageInput")
    const value = messageInput.value

    const payload = {
        message: value,
        name: user.name,
        lastname: user.lastname,
        email: user.email
    }

    socket.emit("send-message", payload)
})

socket.on("connect", () => {
    alert("Conectado")
})

socket.on("disconnect", () => {
    alert("Desconectado")
})

socket.on("send-message", (payload) => {
    const {message, name, lastname, email} = payload

    const msg = document.createElement("div")
    msg.setAttribute("class", `alert ${email != user.email ? "alert-danger" : "alert-success"}`)
    msg.innerText = `Author: ${name} ${lastname} \n
        Message: ${message}`

    messageContainer.appendChild(msg)
})