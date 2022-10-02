import 'package:flutter/material.dart';

class CustomSearchbar extends StatelessWidget {
  const CustomSearchbar(this.textController, this.hintText);
  final TextEditingController textController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    var hintText2 = 'type in AWB No...';
    return  ListTile(
      leading: const Icon(
        Icons.person,
        color: Colors.white,
        size: 28,
      ),
      title: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}