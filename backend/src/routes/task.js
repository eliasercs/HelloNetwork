const {Router} = require("express")
const {addNewTask, getPersonalTasks} = require("../controllers/tasks")
const {validateJWT} = require("../middlewares/validate")

const router = Router()

router.get("/personal", [validateJWT], getPersonalTasks)
router.post("/add", [validateJWT], addNewTask)

module.exports = router