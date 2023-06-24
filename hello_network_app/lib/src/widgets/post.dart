import "package:flutter/material.dart";
import "package:hello_network_app/src/pages/dashboard.dart";
import "package:hello_network_app/src/pages/profile.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/profile.dart";
import "package:fluttericon/font_awesome_icons.dart";

class Avatar extends StatelessWidget {
  final String name;
  final String lastname;
  final String avatar;
  final String date;
  final Map<String, dynamic> profile;
  const Avatar(
      {super.key,
      required this.name,
      required this.lastname,
      required this.avatar,
      required this.date,
      required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ProfileAvatarBase64(
              width: 50,
              height: 50,
              image: avatar,
              callback: () {
                Map<String, dynamic> another_user = profile["author"];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profilePage(
                              user: another_user,
                            )));
              }),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$name $lastname",
                style: TextStyle(fontFamily: "Poppins", fontSize: 18)),
            Text(
              date,
              style: TextStyle(fontFamily: "Poppins", fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}

class PostText extends StatelessWidget {
  final String content;
  PostText({super.key, required this.content});

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
      child: Text(
        content,
        style: TextStyle(fontFamily: "Poppins", fontSize: 15),
      ),
    );
  }
}

class Count extends StatelessWidget {
  final int reactions;
  final int comments;
  Count({super.key, required this.reactions, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(FontAwesome.thumbs_up),
      Padding(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Text(
          reactions.toString(),
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
      ),
      Icon(FontAwesome.commenting),
      Padding(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Text(
          comments.toString(),
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
      ),
    ]);
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

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

class Post extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  Post(this.index, {super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final author = data["author"] as Map<String, dynamic>;
    final comments = data["comments"] as List;
    final date = DateTime.parse(data["datetime"]);
    final y = date.year.toString();
    final m = date.month.toString();
    final d = date.day.toString();
    final h = date.hour.toString();
    final min = date.minute.toString();
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
          children: [
            Avatar(
                name: author["name"],
                lastname: author["lastname"],
                avatar: data["buff"],
                date: "$d/$m/$y a las $h:$min",
                profile: data),
            PostText(
              content: data["content"],
            ),
            Count(
              reactions: data["n_reactions"],
              comments: comments.length,
            ),
            Actions()
          ]),
    );
  }
}

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
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
            child: FutureBuilder(
              future: ApiServices().getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final list = snapshot.data as List;
                    return ListView.builder(
                      primary: false,
                      controller: controller,
                      itemCount: list.length,
                      itemBuilder: (context, index) => Post(
                        index,
                        data: list[index],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No hay publicaciones por mostrar"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}

/*
ListView.builder(
              primary: false,
              controller: controller,
              itemCount: 10,
              itemBuilder: (context, index) => Post(index),
            )
*/
