import 'package:flutter/material.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';
import 'package:hello_network_app/src/utils/preferences.dart';

final _p = Preferences();

Widget checkOnBoarding() {
  return _p.onBoarding == false
      ? const SlideShowPage()
      : checkAuth(Dashboard());
}

Widget checkAuth(Widget widget) {
  return _p.tokenAuth == "" ? const IndexApp() : widget;
}
