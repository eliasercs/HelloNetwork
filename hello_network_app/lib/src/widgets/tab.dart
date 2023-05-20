import "package:flutter/material.dart";

class _tabButton extends StatelessWidget {
  final Function callback;

  _tabButton(this.callback);

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
            borderRadius: BorderRadius.circular(20)),
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
        _tabButton(() {
          print("Personal");
        }),
        _tabButton(() {
          print("Proyectos");
        })
      ]),
    );
  }
}
