import 'package:flutter/material.dart';



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text("Alert"),
        ),
      ),
    );
  }
}