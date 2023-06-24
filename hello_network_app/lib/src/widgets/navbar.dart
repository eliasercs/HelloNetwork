import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
import "package:hello_network_app/src/models/user_model.dart";
import "package:hello_network_app/src/pages/dashboard.dart";
import "package:hello_network_app/src/pages/profile.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/profile.dart";
import "package:provider/provider.dart";

class navbarDashboard extends StatelessWidget {
  final String name;
  final String lastname;
  final String image;

  navbarDashboard(this.name, this.lastname, this.image);

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
          ProfileAvatarBase64(
              width: 65,
              height: 65,
              image: image,
              callback: () {
                Map<String, dynamic> user =
                    Provider.of<UserModel>(context, listen: false).authUser;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profilePage(user: user)));
                //Navigator.pushNamed(context, "/user");
              }),
          /*
          ProfileAvatar(65, 65, "graphics/profile/avatar_user.jpg", () {
            Navigator.pushNamed(context, "/user");
          }
          ),*/
        ],
      ),
    );
  }
}

class navbarRoute extends StatelessWidget {
  final String title;

  navbarRoute(this.title, {super.key});

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
            Provider.of<ErrorModel>(context, listen: false).setError();
            Navigator.pop(context, true);
          }),
          Text(
            title,
            style: TextStyle(
                fontFamily: "PoppinsMedium", fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            width: size.width * 0.1,
          ),
        ],
      ),
    );
  }
}

class navbarRouteAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function action;
  const navbarRouteAction(
      {super.key,
      required this.title,
      required this.icon,
      required this.action});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.1,
      color: const Color(0xff273469),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtn(const Color(0xff273469), const Color(0xfffca311),
              Icons.arrow_back, () {
            Navigator.pop(context, true);
          }),
          Text(
            title,
            style: const TextStyle(
                fontFamily: "PoppinsMedium", fontSize: 18, color: Colors.white),
          ),
          IconBtn(const Color(0xff273469), const Color(0xfffca311), icon,
              () => action()),
        ],
      ),
    );
  }
}
