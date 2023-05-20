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
          margin: EdgeInsets.only(right: 10.0),
          child: ProfileAvatar(
              50, 50, "https://www.w3schools.com/howto/img_avatar.png"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    final Radius radius = Radius.circular(15);

    return Container(
      width: size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      //color: Colors.white,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.white, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.only(
              topRight: radius, bottomLeft: radius, bottomRight: radius)),
      child: Text(
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
    return Row(children: [
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
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Flexible(child: Button("Reaccionar", Color(0xff273469), () {})),
          Flexible(child: Button("Comentar", Color(0xff273469), () {}))
        ],
      ),
    );
  }
}

class post extends StatelessWidget {
  const post({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: const Color(0xffe5e5e5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [avatar(), postText(), count(), actions()]),
    );
  }
}

class posts extends StatelessWidget {
  const posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [post(), post()]),
    );
  }
}
