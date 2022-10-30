import 'package:flutter/material.dart';

class BookingLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onPressed;
  BookingLink({
    required this.text,
    required this.linkText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.all(
          10,
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Text(
              "${text}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${linkText}",
              style: const TextStyle(
                color: Color(
                  0xfff48020,
                ),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}