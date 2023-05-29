import "package:flutter/material.dart";

class Button extends StatelessWidget {
  final String value;
  final Color color;
  final Function callback;
  double? width;
  double? height;
  Color? textColor;

  Button(this.value, this.color, this.callback,
      {super.key, this.width, this.height, this.textColor});

  @override
  Widget build(BuildContext context) {
    // Recuperar la referencia del tamaño del contenedor
    final size = MediaQuery.of(context).size;

    width ??= size.width * 0.5;
    height ??= size.height * 0.05;
    textColor ??= Colors.white;

    return FilledButton(
      onPressed: () {
        // La función depende del Callback que se le pase al Widget
        callback();
      },
      style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor!,
          minimumSize: Size(width!, height!)),
      child: Text(value),
    );
  }
}

class IconBtn extends StatelessWidget {
  final Color bg;
  final Color iconColor;
  final IconData icon;
  final Function callback;
  const IconBtn(this.bg, this.iconColor, this.icon, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: bg,
            shape: const CircleBorder(),
            fixedSize: const Size(60, 60)),
        onPressed: () {
          callback();
        },
        child: Icon(
          icon,
          color: iconColor,
        ));
  }
}
