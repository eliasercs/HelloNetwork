import 'package:flutter/material.dart';

Future newDialog(
        {required dynamic context,
        required dynamic title,
        required dynamic content}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, "Ok"),
                    child: Text("Ok"))
              ],
            ));
