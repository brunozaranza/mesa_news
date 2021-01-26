import 'package:flutter/material.dart';
import 'package:mesa_news/core/keyboard_behavior.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/app_config.dart';
import 'package:mesa_news/ui/router.dart';

class MesaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setupKeyboardBehavior();

    AppConfig appConfig = getServiceLocator<AppConfig>();

    return MaterialApp(
      title: appConfig.title,
      theme: appConfig.theme,
      navigatorKey: appConfig.navigatorKey,
      onGenerateRoute: MesaRouter.generateRoute,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
