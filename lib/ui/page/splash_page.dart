import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/auth_viewmodel.dart';
import 'package:mesa_news/locator.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _img() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 116,
          child: Image.asset("assets/images/logo.png"),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: 16,
            child: Image.asset("assets/images/news.png"),
          ),
        ),
      ],
    );
  }

  void navigationPage() async {
    String userExist = await getServiceLocator<AuthViewModel>().checkUserExist();
    if(userExist.isEmpty) navigateReplaceAllTo(route: "/login");
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: colorPrimary),
          _img(),
        ],
      ),
    );
  }
}
