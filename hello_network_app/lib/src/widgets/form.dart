import "package:flutter/material.dart";

class inputText extends StatelessWidget {
  inputText();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff273469),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff273469)),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff273469)),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          hintText: "¿Qué estás pensando?",
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}

class inputPost extends StatelessWidget {
  const inputPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 80,
      //color: const Color(0xffe5e5e5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: inputText()),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xff273469),
                  shape: CircleBorder(),
                  fixedSize: Size(60, 60)),
              onPressed: () {
                print("Publicar");
              },
              child: Icon(
                Icons.send,
                color: Color(0xfffca311),
              ))
        ],
      ),
    );
  }
}
