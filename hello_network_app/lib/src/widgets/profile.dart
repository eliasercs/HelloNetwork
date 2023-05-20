import "package:flutter/material.dart";

class ProfileAvatar extends StatelessWidget {
  final double width;
  final double height;
  final String url;

  ProfileAvatar(this.width, this.height, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xfffca311), width: 4)),
    );
  }
}
