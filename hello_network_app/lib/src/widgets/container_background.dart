import "package:flutter/material.dart";

class ContainerBackground extends StatelessWidget {
  final String image;
  final Color color;
  final double heightConst;

  const ContainerBackground(this.image, this.heightConst, this.color,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final re = RegExp(r"^http");
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * heightConst,
      decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
              image: re.hasMatch(image)
                  ? NetworkImage(image)
                  : AssetImage(image) as ImageProvider,
              fit: BoxFit.cover)),
    );
  }
}
