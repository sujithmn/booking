import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
   LoginButton({
     required this.text,
     required this.onPressed
   });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(
        context,
      ).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2),
        ],
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xfff48020),
            Color(0xffffcb05),
          ],
        ),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        //onTap: () {
          //onPressed;
          /*_loginBloc.userLogin(login);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LandingPage(),
            ),
          );*/
       //},
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}