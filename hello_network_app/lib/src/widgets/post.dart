import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/profile.dart";
import "package:fluttericon/font_awesome_icons.dart";

class avatar extends StatelessWidget {
  const avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ProfileAvatar(
              50, 50, "https://www.w3schools.com/howto/img_avatar.png"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Eliaser Concha",
                style: TextStyle(fontFamily: "Poppins", fontSize: 18)),
            Text(
              "Fecha",
              style: TextStyle(fontFamily: "Poppins", fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}

class postText extends StatelessWidget {
  const postText({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Radius radius = const Radius.circular(15);

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      //color: Colors.white,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.white, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.only(
              topRight: radius, bottomLeft: radius, bottomRight: radius)),
      child: const Text(
        "Este es un texto de prueba utilizado para crear múltiples componentes de publicación.",
        style: TextStyle(fontFamily: "Poppins", fontSize: 15),
      ),
    );
  }
}

class count extends StatelessWidget {
  const count({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Icon(FontAwesome.thumbs_up),
      Padding(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Text(
          "50",
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
      ),
      Icon(FontAwesome.commenting),
      Padding(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Text(
          "5000",
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
      ),
    ]);
  }
}

class actions extends StatelessWidget {
  const actions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Flexible(child: Button("Reaccionar", const Color(0xff273469), () {})),
          Flexible(child: Button("Comentar", const Color(0xff273469), () {}))
        ],
      ),
    );
  }
}

class post extends StatelessWidget {
  final int index;
  const post(this.index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          color: Color(0xffe5e5e5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [avatar(), postText(), count(), actions()]),
    );
  }
}

class posts extends StatefulWidget {
  const posts({super.key});

  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          child: Scrollbar(
            thickness: 5,
            thumbVisibility: false,
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) => post(index),
            ),
          ),
        ),
      );
    });
  }
}