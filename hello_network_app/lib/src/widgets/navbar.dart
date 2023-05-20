import "package:flutter/material.dart";
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
          ProfileAvatar(
              65, 65, "https://www.w3schools.com/howto/img_avatar.png"),
        ],
      ),
    );
  }
}
