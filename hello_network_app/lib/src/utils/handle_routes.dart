import 'package:flutter/material.dart';
import 'package:hello_network_app/main.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import 'api.dart';

final _p = Preferences();

Widget checkOnBoarding(context) {
  return _p.onBoarding == false
      ? const SlideShowPage()
      : checkAuth(Loading(), context);
}

Widget checkAuth(Widget widget, context) {
  if (_p.tokenAuth.toString().isNotEmpty) {
    try {
      Provider.of<UserModel>(context, listen: false).initUserAuth();
    } on Exception catch (e) {
      print(e);
    }
  }
  return _p.tokenAuth == "" ? const IndexApp() : widget;
}
