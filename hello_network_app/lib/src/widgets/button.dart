import "package:flutter/material.dart";

class Button extends StatelessWidget {
  final String value;
  final Color color;
  final Function callback;

  Button(this.value, this.color, this.callback);

  @override
  Widget build(BuildContext context) {
    // Recuperar la referencia del tamaño del contenedor
    final size = MediaQuery.of(context).size;

    return FilledButton(
      child: Text(value),
      onPressed: () {
        // La función depende del Callback que se le pase al Widget
        callback();
      },
      style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Color(0xffffffff),
          minimumSize: Size(size.width, size.height * 0.05)),
    );
  }
}
