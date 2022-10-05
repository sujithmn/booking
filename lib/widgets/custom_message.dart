import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  final String? hintText;
  const CustomMessage(this.hintText);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(left: 40, top:10, right: 40, bottom:0),
      child: Text(
        hintText!,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontFamily: "Caveat",
        ),
      ),
    );
  }
}