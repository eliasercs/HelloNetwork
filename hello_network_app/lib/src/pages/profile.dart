import "package:flutter/material.dart";
import "package:hello_network_app/src/models/user_model.dart";
import "package:hello_network_app/src/pages/edit_profile.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/profile.dart";
import "package:provider/provider.dart";

class _navCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final String title;
  final IconData? iconData;
  final Function callback;
  const _navCard(this.title, this.iconData,
      {super.key, required this.user, required this.callback});

  @override
  Widget build(BuildContext context) {
    final id = Provider.of<UserModel>(context).getValue("_id");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: "Poppins", fontSize: 18),
        ),
        user["_id"] == id
            ? IconBtn(Colors.transparent, Colors.black, iconData!, () {
                callback();
              })
            : SizedBox()
      ],
    );
  }
}

class navBarProfile extends StatelessWidget {
  final Map<String, dynamic> user;
  navBarProfile({required this.user});

  void settings() {
    //ApiServices().getAvatar();
    print("Settings");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final id = Provider.of<UserModel>(context).getValue("_id");
    final name = user["name"];
    final lastname = user["lastname"];
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
            image: user["buff"],
            callback: () {
              Navigator.pushNamed(context, "/chat_user");
            }),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Container(
              width: size.width * 0.5,
              child: Text("$name $lastname",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                      color: Colors.white)),
            ),
            const SizedBox(
              height: 5,
            ),
            user["_id"] != id
                ? SizedBox()
                : Button(
                    "Cerrar sesión",
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
class _cardList extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Map<String, dynamic> user;
  final List list;
  final Function callback;

  _cardList(this.title, this.icon,
      {super.key,
      required this.user,
      required this.list,
      required this.callback});

  @override
  State<_cardList> createState() => _cardListState();
}

class _cardListState extends State<_cardList> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = widget.list;
    return Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            _navCard(
              widget.title,
              widget.icon,
              user: widget.user,
              callback: widget.callback,
            ),
            SizedBox(height: 10),
            widget.list.length > 0
                ? Container(
                    height: size.height * 0.15,
                    child: ListView.builder(
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final element = data[index];
                          DateTime start =
                              DateTime.parse(element["date_start"]);
                          DateTime end = DateTime.parse(element["date_end"]);
                          final ys = start.year.toString();
                          final ms = start.month.toString();
                          final ds = start.day.toString();

                          final ye = end.year.toString();
                          final me = end.month.toString();
                          final de = end.day.toString();

                          return _ListItem(
                            place: element["place"],
                            date: "$ds/$ms/$ys - $de/$me/$ye",
                            position: element["position"],
                          );
                        }))
                : SizedBox()
          ],
        ));
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem(
      {super.key,
      required this.place,
      required this.date,
      required this.position});

  final String place;
  final String date;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // Place
          place,
          style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 15),
        ),
        Text(
          // Fechas
          date,
          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
        ),
        Text(
          // Descripción, cargo o lo que sea
          position,
          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
        )
      ],
    );
  }
}

class CardOne extends StatelessWidget {
  final String title;
  final String description;
  final double height;
  final Map<String, dynamic> user;

  const CardOne(
      {super.key,
      required this.title,
      required this.description,
      this.height = 50,
      required this.user});

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
            _navCard(
              title,
              Icons.edit,
              user: user,
              callback: () {
                editDescription(context);
              },
            ),
            const SizedBox(height: 10),
            description != ""
                ? Container(
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
                : SizedBox()
          ],
        ));
  }
}

class profileBody extends StatelessWidget {
  final Map<String, dynamic> user;
  const profileBody({super.key, required this.user});

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
                const SizedBox(height: 5),
                CardOne(
                  height: (size.height * 0.2),
                  title: "Descripción",
                  description: user["description"],
                  user: user,
                ),
                const SizedBox(height: 5),
                _cardList(
                  "Educación",
                  Icons.add,
                  user: user,
                  list: user["education"],
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditEducationHistory()));
                  },
                ),
                const SizedBox(height: 5),
                _cardList(
                  "Experiencia Laboral",
                  Icons.add,
                  user: user,
                  list: user["jobs"],
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditExperience()));
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class profilePage extends StatelessWidget {
  final Map<String, dynamic> user;

  profilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          navbarRoute("Perfil de Usuario"),
          navBarProfile(
            user: user,
          ),
          Expanded(child: profileBody(user: user))
        ],
      )),
    );
  }
}
