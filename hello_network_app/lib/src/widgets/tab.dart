import "package:flutter/material.dart";

class _tabButton extends StatelessWidget {
  final String text;
  final String image;
  final Function callback;

  _tabButton(this.text, this.image, this.callback);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: size.width * 0.44,
        height: size.height,
        decoration: BoxDecoration(
            color: const Color(0xfffca311),
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "PoppinsMedium",
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class tab extends StatelessWidget {
  const tab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.2,
      //color: const Color(0xffe5e5e5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _tabButton("Tablero Personal", "graphics/bg/1.jpg", () {
          print("Personal");
        }),
        _tabButton("Tablero de Proyectos", "graphics/bg/2.jpg", () {
          print("Proyectos");
        })
      ]),
    );
  }
}