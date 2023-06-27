const Server = require("../src/models/Server")
const Request = require("supertest")

const server = new Server()
const app = server.app

describe("POST Auth /api/auth/signin", () => {
    const body = {"email": "eliaserdev99@gmail.com", "password": "Crack1352021#"}
    const endpoint = Request(app).post("/api/auth/signin")

    test('should respond with a 200 status code', async () => {
        const response = await endpoint.send(body)
        expect(response.statusCode).toBe(200)
    })

    test('should respond with a JSON response', async () => {
        const response = await endpoint.send(body)
        expect(response.type).toBe("application/json")
    })

    test('should respond with a Auth Token', async () => {
        const response = await endpoint.send(body)
        expect(response.body.token).not.toBeNull()
    })
})