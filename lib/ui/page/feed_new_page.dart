import 'package:flutter/material.dart';

class FeedNewPage extends StatefulWidget {
  @override
  _FeedNewPageState createState() => _FeedNewPageState();
}

class _FeedNewPageState extends State<FeedNewPage> {

  _appBar() {
    return AppBar(
      title: Text("Título da matéria"),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }
}