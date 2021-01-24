import 'package:flutter/material.dart';
import 'package:mesa_news/core/constant.dart';

class AppConfig {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String get title => "Mesa News";

  ThemeData get theme => ThemeData(
    primaryColor: colorPrimary,
    accentColor: colorAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}