import 'package:flutter/material.dart';

class MesaButton extends StatelessWidget {

  final Function onTap;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  MesaButton(
      {@required this.title,
      @required this.onTap,
      this.textColor = Colors.white,
      this.backgroundColor = const Color(0xFF010A53),
      this.borderColor = Colors.white});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
