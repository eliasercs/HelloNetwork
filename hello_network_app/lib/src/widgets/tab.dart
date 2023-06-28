import "package:flutter/material.dart";
import "package:hello_network_app/src/pages/kanban.dart";
import "package:provider/provider.dart";

import "../models/task_model.dart";
import "../utils/api.dart";

class _TabButton extends StatelessWidget {
  final String text;
  final String image;
  final Function callback;

  const _TabButton(this.text, this.image, this.callback);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        width: size.width * 0.44,
        height: size.height,
        decoration: BoxDecoration(
            color: const Color(0xfffca311),
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "PoppinsMedium",
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.2,
      //color: const Color(0xffe5e5e5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _TabButton("Tablero Personal", "graphics/bg/1.jpg", () {
          ApiServices().getAllTasks().then((value) {
            Provider.of<TaskModel>(context, listen: false).setTasks(value);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Kanban("Tareas Individuales", false)));
        }),
        _TabButton("Chat entre usuarios", "graphics/bg/2.jpg", () {
          Navigator.pushNamed(context, "/chat_user");
        })
      ]),
    );
  }
}
