import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_network_app/main.dart';
import 'package:hello_network_app/src/models/form_model.dart';
import 'package:hello_network_app/src/widgets/button.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import 'package:hello_network_app/src/widgets/form.dart';
import 'package:hello_network_app/src/widgets/profile.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/user_model.dart';
import '../widgets/navbar.dart';

class InputChat extends StatefulWidget {
  final String placeholder;
  const InputChat({super.key, required this.placeholder});

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  TextEditingController controller = TextEditingController();
  Color prefColor = Colors.white;
  Socket socket = io("http://10.0.2.2:8000");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    socket.onConnect((_) {
      print("connect");
      socket.emit('send-message', "Hola Mundo desde flutter");
    });
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Color(0xff273469), borderRadius: BorderRadius.circular(40)),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              cursorColor: Color(0xffF9A826),
              style: TextStyle(color: Color(0xffF9A826)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: TextStyle(color: Colors.white),
                focusColor: Color(0xffF9A826),
              ),
            )),
            IconBtn(
                Colors.white.withOpacity(0.25), Color(0xffFFC700), Icons.send,
                () {
              socket.emit("send-message", {
                "name": "Eliaser",
                "lastname": "Concha",
                "message": controller.text
              });
              //print(controller.text);
            })
          ],
        ));
  }
}

class UserChat extends StatelessWidget {
  const UserChat({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context, listen: true).authUser;
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Color(0xff1E2749),
        child: Column(children: [
          navbarRoute("Chat entre usuarios"),
          Expanded(
              child: Container(
            height: size.height,
            color: Color(0xff1E2749),
            child: StreamBuilder(
                stream: streamSocket.getChats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: ((context, index) =>
                            data[index]["name"] == user["name"]
                                ? ChatTextLeft(
                                    text: data[index]["message"],
                                    avatar: user["buff"])
                                : ChatTextRight(
                                    text: data[index]["message"],
                                    avatar: user["buff"])));
                  } else {
                    return Text("");
                  }
                }),
          )),
          _ChatForm()
        ]),
      ),
    ));
  }
}

class _ChatForm extends StatefulWidget {
  const _ChatForm({
    super.key,
  });

  @override
  State<_ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<_ChatForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Color(0xff1E2749),
      child: InputChat(placeholder: "Escribe tu mensaje ..."),
    );
  }
}

class ChatTextRight extends StatelessWidget {
  final String text;
  final String avatar;
  const ChatTextRight({super.key, required this.text, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        ProfileAvatarBase64(
            width: 50, height: 50, image: avatar, callback: () {}),
        Container(
          width: w - 60,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Text(
            text,
            style: TextStyle(fontFamily: "Poppins", fontSize: 15),
          ),
        )
      ],
    );
  }
}

class ChatTextLeft extends StatelessWidget {
  final String text;
  final String avatar;
  const ChatTextLeft({super.key, required this.text, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: w - 60,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Text(
            text,
            style: TextStyle(fontFamily: "Poppins", fontSize: 15),
          ),
        ),
        ProfileAvatarBase64(
            width: 50, height: 50, image: avatar, callback: () {}),
      ],
    );
  }
}
