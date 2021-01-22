import 'package:flutter/material.dart';
import 'package:mesa_news/core/util/color_util.dart';

class MesaTextField extends StatelessWidget {

  final String label;
  final String hint;
  final bool password;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final Size size;
  final Function() onFieldSubmitted;

  MesaTextField({
    @required this.label,
    this.hint,
    this.password = false,
    this.icon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onChanged,
    this.focusNode,
    this.nextFocus,
    this.size,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: colorTextField,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 60.0,
          width: size == null ? double.maxFinite : (size.width/2) - 25,
          child: TextFormField(
            controller: controller,
            obscureText: password,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onChanged: onChanged,
            onFieldSubmitted: (String text) {
              onFieldSubmitted();
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              }
            },
            style: TextStyle(
              color: colorPrimary,
            ),
            decoration: mesaInputDecoration(),
          ),
        ),
      ],
    );
  }

  InputDecoration mesaInputDecoration() {
    return icon != null
        ? InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(top: 14.0),
      prefixIcon: Icon(
        icon,
        color: colorPrimary,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: colorPrimary,
      ),
    )
        : InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(10.0),
      hintText: hint,
      hintStyle: TextStyle(
        color: colorPrimary,
      ),
    );
  }
}
