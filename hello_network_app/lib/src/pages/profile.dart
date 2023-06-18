import "package:flutter/material.dart";
import "package:hello_network_app/src/utils/api.dart";
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
  final String image;
  navBarProfile({required this.image});

  void settings() {
    //ApiServices().getAvatar();
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
          color: Color(0xff1E2749),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(75),
              bottomRight: Radius.circular(35))),
      child: Row(children: [
        ProfileAvatarBase64(
            width: 150,
            height: 150,
            image: image,
            callback: () {
              Navigator.pushNamed(context, "/chat_user");
            }),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Eliaser Concha",
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 25, color: Colors.white)),
            const Text(
              "@eliasercs",
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            "2" != "1"
                ? Button(
                    "Seguir",
                    const Color(0xfffca311),
                    () {},
                    textColor: Color(0xff1E2749),
                  )
                : Button(
                    "Settings",
                    const Color(0xfffca311),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            _navCard(title, icon),
            SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            )
          ],
        ));
  }
}

class CardOne extends StatelessWidget {
  final String title;
  final String description;
  final double height;

  const CardOne(
      {super.key,
      required this.title,
      required this.description,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            _navCard(title, Icons.dangerous),
            const SizedBox(height: 10),
            Container(
              height: height,
              alignment: AlignmentDirectional.centerStart,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: description,
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.black))),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const followsNumbers(),
                const SizedBox(height: 5),
                CardOne(
                  height: (size.height * 0.2),
                  title: "Descripción",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                ),
                const SizedBox(height: 5),
                const _cardList("Educación", Icons.abc),
                const SizedBox(height: 5),
                const _cardList("Experiencia Laboral", Icons.abc),
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
  final String image;
  profilePage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          navbarRoute("Perfil de Usuario"),
          navBarProfile(
            image: image,
          ),
          Expanded(child: profileBody())
        ],
      )),
    );
  }
}
