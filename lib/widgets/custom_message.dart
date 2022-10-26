import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  final String? hintText;
  const CustomMessage(this.hintText);
  @override
  Widget build(BuildContext context) {
    return  Card( child: Container(
      margin: const EdgeInsets.only(left: 40, top:0, right: 40, bottom:0),
      child: Text(
        hintText!,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 20.0,
          fontFamily: "Georgia",
            fontWeight: FontWeight.bold,
        ),
      )
    ),
    );
  }
}