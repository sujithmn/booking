// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:ffi';
import 'package:booking/pages/landing_page.dart';
import 'package:booking/bloc/login_signup_bloc.dart';
import 'package:booking/widgets/booking_link.dart';
import 'package:booking/widgets/login_button.dart';
import 'package:booking/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import '../model/login_user.dart';
import 'package:booking/bloc/globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc = LoginBloc();
  LoginUser login = LoginUser();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          decoration: BoxDecoration(color: Colors.white),
          child: Form(
            key: _formKey,
            child:Stack(
            children: <Widget>[

              Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: MediaQuery.of(context).size.width * 0.30,//TRY TO CHANGE THIS **0.30** value to achieve your goal
                  child: Container(
                    margin: EdgeInsets.all(16.0),

                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/logo.png', scale: 1)
                        ]
                    ),
                  )),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),

                      SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Phone';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  onChanged: (newText) { login.username = newText; },
                                  textAlign: TextAlign.start,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: "mobile number",
                                    suffixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    fillColor: Color(
                                      0xfff3f3f4,
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    return null;
                                  },
                                  onChanged: (newText) { login.password = newText; },
                                  decoration: InputDecoration(
                                    hintText: "password",
                                    suffixIcon: Icon(
                                      Icons.visibility,
                                      color: Colors.black54,
                                    ),
                                    // icon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    fillColor: Color(
                                      0xfff3f3f4,
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     LoginButton(
                         text:'Login',
                       onPressed: (){
                         _loginBloc.userLogin(login);
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => LandingPage(),
                           ),
                         );
                         }
                     ),

                     BookingLink(text: '', linkText: 'Forgot Passoword', onPressed: (){

                     }),
                      SizedBox(
                        height: 1,
                      ),
                      BookingLink(text: "Don\'t have an account ?", linkText: 'Register',
                          onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        ),
      ),
    );
    Future<Bool> remoteLogin() async {
      final response = await http.get(Uri.parse('https://www.tpcglobe.com/tpCWebService/Customerlog.aspx'));
      if (response.statusCode == 200) {}
      print(response.body);
      //List responseJson = json.decode(response.body.toString());
      //List<User> userList = createUserList(responseJson);
    }
  }



}


