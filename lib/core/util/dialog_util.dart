import 'package:flutter/material.dart';
import 'package:mesa_news/core/util/navigator_util.dart';

Future<T> showMessageDialog<T>({@required BuildContext context, @required String msg}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(msg),
            actions:[FlatButton(
              child: Text("OK"),
              onPressed: () {
                navigatePop();
              },
            ),]
        );
      });
}