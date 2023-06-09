import 'package:flutter/material.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';
import 'package:hello_network_app/src/utils/preferences.dart';

import 'api.dart';

final _p = Preferences();

Widget checkOnBoarding(context) {
  return _p.onBoarding == false
      ? const SlideShowPage()
      : checkAuth(Dashboard(), context);
}

Widget checkAuth(Widget widget, context) {
  if (_p.tokenAuth.toString().isNotEmpty) {
    ApiServices().getUserAuth(context);
  }
  return _p.tokenAuth == "" ? const IndexApp() : widget;
}
