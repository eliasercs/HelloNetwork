import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/profile.dart";

class navbarDashboard extends StatelessWidget {
  final String name;
  final String lastname;

  navbarDashboard(this.name, this.lastname);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      //color: const Color(0xffe5e5e5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bienvenido",
                style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
              ),
              Text(
                '$name $lastname',
                style:
                    const TextStyle(fontSize: 18, fontFamily: "PoppinsMedium"),
              )
            ],
          ),
          ProfileAvatar(65, 65, "graphics/profile/avatar_user.jpg", () {
            Navigator.pushNamed(context, "/user");
          }),
        ],
      ),
    );
  }
}

class navbarRoute extends StatelessWidget {
  navbarRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.1,
      color: Color(0xff273469),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtn(Color(0xff273469), Color(0xfffca311), Icons.arrow_back, () {
            Navigator.pop(context, true);
            print("back");
          }),
          Text(
            "Perfil de usuario",
            style: TextStyle(
                fontFamily: "PoppinsMedium", fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            width: size.width * 0.1,
          )
        ],
      ),
    );
  }
}
