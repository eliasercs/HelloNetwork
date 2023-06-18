const userHTML = document.getElementById("user")
const messageInput = document.getElementById("messageInput")
const sendMessage = document.getElementById("sendMessage")
const messageContainer = document.getElementById("messageContainer")
const users_active = document.getElementById("users-active")

let id_user = "648cc2f2dd3f778c3aebc982"

const user = {
    name: "Soporte",
    lastname: "Hello Network",
    email: "soporte@hellonetwork.com",
    password: "Crack1352021#"
}

const connectSocket = async (token) => {
    const socket = io({
        'extraHeaders': {
            'auth-token' : token
        }
    })

    socket.emit("rescue-messages", id_user)

    socket.on("get-messages", (payload) => {
        console.log(payload)

        payload.forEach(({content}) => {
            let dom_element = document.createElement("div")
            dom_element.setAttribute("class", `alert alert-info`)
            dom_element.innerText = `${content}`
            messageContainer.appendChild(dom_element)
        });
    })

    socket.on("active-users", (payload) => {
        const active = payload["data"]
        console.log(active)
        active.forEach(({id, name, lastname}) => {
            let dom_element = document.createElement("div")
            dom_element.setAttribute("id", id)
            let alert = name !== user["name"] && lastname !== user["lastname"] ? "alert-success" : "alert-warning"
            dom_element.setAttribute("class", `alert ${alert}`)
            dom_element.innerText = `${name} ${lastname}`
            users_active.appendChild(dom_element)
        });

        const alert_success = document.querySelectorAll(".alert-success")
        
        alert_success.forEach((element) => {
            element.addEventListener("click", (e) => {
                id_user = e.target.id
            })
        })
    })
    socket.on("private-message", (payload) => {
        console.log(payload)
        let alert = payload["from"] !== user["name"] ? "alert-success" : "alert-warning"
        let element = document.createElement("div")
        element.setAttribute("class", `alert ${alert}`)
        element.innerText = `[${payload["from"]}]: ${payload["message"]}`
        messageContainer.appendChild(element)
    })

    sendMessage.addEventListener("click", () => {
        message = messageInput.value
        socket.emit("private-message", {
            uid: id_user, 
            from: user["name"],
            message
        })
    })
}

const login = async () => {
    const response = await fetch("/api/auth/signin", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            email: user.email,
            password: user.password
        })
    })

    const data = await response.json()

    localStorage.setItem("auth-token", data["token"])

    await connectSocket(localStorage.getItem("auth-token"))

    userHTML.innerText = `${user["name"]} ${user["lastname"]}`
}

login()