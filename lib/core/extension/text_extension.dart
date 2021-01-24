import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text h1() => Text(this.data,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black,
      ));

  Text h2() => Text(this.data,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ));
}
