import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/profile.dart";

class _navCard extends StatelessWidget {
  final String title;
  final IconData? iconData;
  const _navCard(this.title, this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: "Poppins", fontSize: 18),
        ),
        Icon(
          iconData,
          color: Colors.black,
        )
      ],
    );
  }
}

class navBarProfile extends StatelessWidget {
  final String id;

  navBarProfile(this.id);

  void settings() {
    print("Settings");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: size.height * 0.25,
      decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(75),
              bottomRight: Radius.circular(35))),
      child: Row(children: [
        ProfileAvatar(150, 150, "graphics/profile/avatar_user.jpg", () {}),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Eliaser Concha",
                style: TextStyle(fontFamily: "Poppins", fontSize: 25)),
            const Text(
              "@eliasercs",
              style: TextStyle(fontFamily: "Poppins", fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            id != "1"
                ? Button(
                    "Seguir",
                    Colors.yellow,
                    () {},
                    textColor: Colors.black,
                  )
                : Button(
                    "Settings",
                    Colors.yellow,
                    settings,
                    textColor: Colors.black,
                  )
          ],
        )
      ]),
    );
  }
}

// Tarjeta que recibe una lista de datos
class _cardList extends StatelessWidget {
  final String title;
  final IconData? icon;

  const _cardList(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            _navCard(title, icon),
            SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            )
          ],
        ));
  }
}

class card extends StatelessWidget {
  const card({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            _navCard("Descripción", Icons.dangerous),
            SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            )
          ],
        ));
  }
}

class profileBody extends StatelessWidget {
  const profileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                followsNumbers(),
                SizedBox(height: 5),
                card(),
                SizedBox(height: 5),
                _cardList("Educación", Icons.abc),
                SizedBox(height: 5),
                _cardList("Experiencia Laboral", Icons.abc),
              ],
            )),
      ),
    );
  }
}

class followsNumbers extends StatelessWidget {
  const followsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.black12),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [Text("1260"), Text("Seguidores")],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [Text("0"), Text("Seguidos")],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [Text("0"), Text("Publicaciones")],
        )
      ]),
    );
  }
}

class profilePage extends StatelessWidget {
  final String id;

  profilePage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          navbarRoute("Perfil de Usuario"),
          navBarProfile(id),
          Expanded(child: profileBody())
        ],
      )),
    );
  }
}
