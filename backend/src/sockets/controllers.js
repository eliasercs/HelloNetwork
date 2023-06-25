const Socket = require("socket.io");
const { checkSockets } = require("../middlewares/validate");
const ChatInfo = require("../models/ChatInfo");
const Message = require("../models/Message");
const {UserModel : User} = require("../models/User");
const jwt = require("jsonwebtoken")

const fs = require("node:fs");
const path = require("node:path");

const chat = new ChatInfo();

const getMessage = async (payload, user) => {
  let result1 = await Message.find({ author: user.id });
  let result2 = await Message.find({ author: payload });
  let another_user = await User.findById(payload);

  let buff1 = fs
  .readFileSync(path.normalize(user["avatar"]["image"]))
  .toString();

  let buff2 = fs
    .readFileSync(path.normalize(another_user["avatar"]["image"]))
    .toString();

    result1 = result1.map((element) => {
        const { content, _id, author, receiver, date, __v } = element;
        let c = jwt.verify(content, `${date}`)
        return { _id, content: c["message"], author, receiver, date, __v, buff: buff1 };
      });

  result2 = result2.map((element) => {
    const { content, _id, author, receiver, date, __v } = element;
    let c = jwt.verify(content, `${date}`)
    return { _id, content: c["message"], author, receiver, date, __v, buff: buff2 };
  });

  let result = [...result1, ...result2];

  const sortedArray = result.slice().sort(
    (a, b) => new Date(a.date).getTime() - new Date(b.date).getTime()
  );

  return sortedArray;
};

const socketController = async (socket, io) => {
  const token = socket.handshake.headers["auth-token"];
  const user = await checkSockets(token);

  if (!user) {
    return socket.disconnect();
  }

  // Conectar a una sala especial
  socket.join(user.id);

  // Conectar usuarios
  chat.connectUser(user);
  io.emit("active-users", { data: chat.UsersArr });

  socket.on("active", (payload) => {
    io.emit("active-users", { data: chat.UsersArr });
  });

  // Limpiar cuando un usuario se desconecta
  socket.on("disconnect", () => {
    chat.desconnectUser(user.id);
    io.emit("active-users", { data: chat.UsersArr });
  });

  socket.on("private-message", async (payload) => {
    console.log(payload);
    const { uid, message } = payload;

    //console.log(`De: ${user.id} Para: ${uid}`);

    const msg = await new Message({
      content: message,
      author: user.id,
      receiver: uid,
      date: Date.now()
    });
    const msg_c = jwt.sign({message}, `${msg["date"]}`)
    console.log(msg_c)
    msg.content = msg_c
    await msg.save();

    const allMessage = await getMessage(uid, user)

    io.to(uid).emit("get-messages", allMessage);
  });

  socket.on("rescue-messages", async (payload) => {
    if (payload !== "") {
      const msg = await getMessage(payload, user)
      io.to(user.id).emit("get-messages", msg);
    } else {
      io.to(user.id).emit("get-messages", []);
    }
  });
};

module.exports = { socketController };
