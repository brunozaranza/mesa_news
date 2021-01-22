import 'package:flutter/material.dart';
import 'package:mesa_news/core/util/color_util.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  _appBar() {
    return AppBar(
      title: Text("Título da matéria"),
      centerTitle: true,
      actions: [
        FlatButton(
            onPressed: () => print("Limpar"),
            child: Text(
              "Limpar",
              style: TextStyle(color: colorLink),
            )),
      ],
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
