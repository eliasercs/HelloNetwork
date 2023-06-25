import "package:flutter/material.dart";
import "package:hello_network_app/src/models/post_model.dart";
import "package:hello_network_app/src/pages/dashboard.dart";
import "package:hello_network_app/src/pages/edit_profile.dart";
import "package:hello_network_app/src/pages/profile.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/utils/validate.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/dialog.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/profile.dart";
import "package:fluttericon/font_awesome_icons.dart";
import "package:provider/provider.dart";

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
  final String id_post;
  Future<dynamic> endpoint;
  Count({super.key, required this.id_post, required this.endpoint});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiServices().countCommentsAndReactions(id_post),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Row(children: [
                Icon(FontAwesome.thumbs_up),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    data["reactions"].toString(),
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  ),
                ),
                Icon(FontAwesome.commenting),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    data["comments"].toString(),
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  ),
                ),
              ]);
            } else {
              return CircularProgressIndicator();
            }
          } else {
            return SizedBox();
          }
        });
  }
}

class Actions extends StatelessWidget {
  final String id_post;
  final Function callback;
  const Actions({super.key, required this.id_post, required this.callback});

  @override
  Widget build(BuildContext context) {
    String btnValue = "Reacción";
    Color color = Color(0xff273469);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Flexible(
              child: Button(btnValue, color, () async {
            try {
              final response = await ApiServices().addReaction(id_post);
              callback();
              newDialog(
                  context: context,
                  title: "Información",
                  content: response["msg"]);
            } on Exception catch (e) {
              newDialog(
                  context: context,
                  title: "Advertencia",
                  content: e.toString());
            }
          })),
          Flexible(
              child: Button("Comentar", const Color(0xff273469), () {
            // Crear nueva vista para los comentarios
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _CommentPage(
                          id_post: id_post,
                        )));
            callback();
          }))
        ],
      ),
    );
  }
}

class Post extends StatefulWidget {
  final int index;
  final Map<String, dynamic> data;
  Post(this.index, {super.key, required this.data});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  Future<dynamic>? count = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = ApiServices().countCommentsAndReactions(widget.data["_id"]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final author = widget.data["author"] as Map<String, dynamic>;
    final date = DateTime.parse(widget.data["datetime"]);
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
                avatar: widget.data["buff"],
                date: "$d/$m/$y a las $h:$min",
                profile: widget.data),
            PostText(
              content: widget.data["content"],
            ),
            Count(
              id_post: widget.data["_id"],
              endpoint: count!,
            ),
            Actions(
                id_post: widget.data["_id"],
                callback: () {
                  count = ApiServices()
                      .countCommentsAndReactions(widget.data["_id"]);
                  setState(() {});
                })
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

class _CommentPage extends StatefulWidget {
  final String id_post;
  _CommentPage({super.key, required this.id_post});

  @override
  State<_CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<_CommentPage> {
  String inputValue = "";
  Future<dynamic>? getComments = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments = ApiServices().getComments(widget.id_post);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        navbarRoute("Comentarios"),
        Expanded(
            child: Container(
          child: FutureBuilder(
            future: getComments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List data = snapshot.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final user = data[index]["user"];
                        return _CommentWidget(
                            buff: user["buff"],
                            date: DateTime.parse(data[index]["datetime"]),
                            name: user["name"],
                            lastname: user["lastname"],
                            comment: data[index]["comment"]);
                      });
                } else {
                  return Center(
                    child: Text("No hay comentarios"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )),
        Row(
          children: [
            Expanded(
                child: EditInput(
                    icon: Icon(Icons.comment),
                    placeholder: "Escribe tu comentario",
                    callback: (value) {
                      inputValue = value;
                      setState(() {});
                    })),
            IconBtn(Colors.black, Colors.amber, Icons.send, () async {
              if (validateString(inputValue)) {
                try {
                  final response = await ApiServices()
                      .addComment(widget.id_post, inputValue);
                  newDialog(
                      context: context,
                      title: "Información",
                      content: response["msg"]);
                  getComments = ApiServices().getComments(widget.id_post);
                  setState(() {});
                } on Exception catch (e) {
                  newDialog(
                      context: context,
                      title: "Advertencia",
                      content: e.toString());
                }
              } else {
                newDialog(
                    context: context,
                    title: "Advertencia",
                    content: "El comentario no puede estar vacío.");
              }
            })
          ],
        )
      ]),
    ));
  }
}

class _CommentWidget extends StatelessWidget {
  final String buff;
  final String name;
  final String lastname;
  final DateTime date;
  final String comment;
  const _CommentWidget(
      {super.key,
      required this.buff,
      required this.date,
      required this.name,
      required this.lastname,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    final d =
        "${date.day}/${date.month}/${date.year} a las ${date.hour}:${date.minute}";
    TextStyle head = TextStyle(fontFamily: "PoppinsMedium", fontSize: 15);
    TextStyle body = TextStyle(fontFamily: "Poppins", fontSize: 14);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        ProfileAvatarBase64(
            width: 50, height: 50, image: buff, callback: () {}),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "$name $lastname",
              style: head,
            ),
            Text(
              d,
              style: body,
            ),
            Text(
              comment,
              style: body,
            )
          ]),
        ))
      ]),
    );
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
