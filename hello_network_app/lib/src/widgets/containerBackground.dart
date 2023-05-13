import "package:flutter/material.dart";

class ContainerBackground extends StatelessWidget {
  final String image;
  final Color color;
  final double heightConst;

  ContainerBackground(this.image, this.heightConst, this.color);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * heightConst,
      decoration: BoxDecoration(
          color: color,
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    );
  }
}
