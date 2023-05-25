import "package:flutter/material.dart";

class ProfileAvatar extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final Function callback;

  ProfileAvatar(this.width, this.height, this.image, this.callback);

  @override
  Widget build(BuildContext context) {
    final re = RegExp(r"r^http");

    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: re.hasMatch(image)
                    ? NetworkImage(image)
                    : AssetImage(image) as ImageProvider,
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(150),
            border: Border.all(color: const Color(0xfffca311), width: 4)),
      ),
    );
  }
}
