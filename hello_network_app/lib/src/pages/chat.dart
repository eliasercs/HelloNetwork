import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_network_app/main.dart';
import 'package:hello_network_app/src/models/form_model.dart';
import 'package:hello_network_app/src/utils/api.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:hello_network_app/src/widgets/button.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import 'package:hello_network_app/src/widgets/form.dart';
import 'package:hello_network_app/src/widgets/profile.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/user_model.dart';
import '../widgets/navbar.dart';

Preferences _p = Preferences();
final String _prodAPI = "https://hellonetwork-production.up.railway.app";

class InputChat extends StatefulWidget {
  final String placeholder;
  final String user_id;
  const InputChat(
      {super.key, required this.placeholder, required this.user_id});

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  TextEditingController controller = TextEditingController();
  Color prefColor = Colors.white;
  Socket socket = io(
      "$_prodAPI",
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {"auth-token": _p.tokenAuth}).build());

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
    final user = Provider.of<UserModel>(context, listen: true).authUser;
    socket.onConnect((_) {
      print("connect");
      //socket.emit('send-message', "Hola Mundo desde flutter");
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
              socket.emit("private-message", {
                "uid": widget.user_id,
                "from": user["name"],
                "message": controller.text
              });
              socket.emit("rescue-messages", widget.user_id);
              //print(controller.text);
            })
          ],
        ));
  }
}

class UserChat extends StatelessWidget {
  final String user_id;
  const UserChat({super.key, required this.user_id});

  @override
  Widget build(BuildContext context) {
    Socket socket = io(
        "$_prodAPI",
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {"auth-token": _p.tokenAuth}).build());
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context, listen: true).authUser;
    socket.emit("rescue-messages", user_id);
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
                stream: streamSocket.getResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: ((context, index) {
                          return data[index]["author"] == user["_id"]
                              ? ChatTextLeft(
                                  text: data[index]["content"],
                                  avatar: data[index]["buff"])
                              : ChatTextRight(
                                  text: data[index]["content"],
                                  avatar: data[index]["buff"]);
                        }));
                  } else {
                    return Text("");
                  }
                }),
          )),
          _ChatForm(
            user_id: user_id,
          )
        ]),
      ),
    ));
  }
}

class _ChatForm extends StatefulWidget {
  final String user_id;
  const _ChatForm({super.key, required this.user_id});

  @override
  State<_ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<_ChatForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Color(0xff1E2749),
      child: InputChat(
        placeholder: "Escribe tu mensaje ...",
        user_id: widget.user_id,
      ),
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

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  Socket socket = io(
      "$_prodAPI",
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {"auth-token": _p.tokenAuth}).build());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    socket.emit("active", "Hola Mundo desde Flutter");

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            navbarRoute("Usuarios Activos"),
            Expanded(
                child: Container(
              width: size.width,
              height: size.height,
              child: StreamBuilder<dynamic>(
                key: Key("UsersActive"),
                stream: streamSocket.getActiveUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var count = 0;
                    for (var element in snapshot.data) {
                      count += 1;
                    }
                    return ListView.builder(
                        itemCount: count,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return _UserOption(
                            avatar: snapshot.data[index]["avatar"],
                            name: snapshot.data[index]["name"],
                            lastname: snapshot.data[index]["lastname"],
                            user_id: snapshot.data[index]["id"],
                          );
                        });
                  }
                },
              ),
            ))
          ],
        ),
      ),
    ));
  }
}

class _UserOption extends StatelessWidget {
  const _UserOption(
      {super.key,
      required this.avatar,
      required this.name,
      required this.lastname,
      required this.user_id});

  final String avatar;
  final String name;
  final String lastname;
  final String user_id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserChat(user_id: user_id))),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          ProfileAvatarBase64(
              width: 50, height: 50, image: avatar, callback: () {}),
          SizedBox(
            width: 10,
          ),
          Text(
            "$name $lastname",
            style: TextStyle(fontFamily: "Poppins", fontSize: 15),
          )
        ]),
      ),
    );
  }
}
