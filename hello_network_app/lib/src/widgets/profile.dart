import "dart:convert";

import "package:flutter/material.dart";

class ProfileAvatar extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final Function callback;

  const ProfileAvatar(this.width, this.height, this.image, this.callback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final re = RegExp(r"^http");

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

class ProfileAvatarBase64 extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final Function callback;
  const ProfileAvatarBase64(
      {super.key,
      required this.width,
      required this.height,
      required this.image,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: MemoryImage(base64Decode(image)), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(150),
            border: Border.all(color: const Color(0xfffca311), width: 4)),
      ),
    );
  }
}
