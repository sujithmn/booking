import 'package:flutter/material.dart';
import 'package:booking/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:booking/screens/login_page.dart';

import '../bloc/login_signup_bloc.dart';
import 'package:booking/bloc/globals.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Register';

    return MaterialApp(
     // title: appTitle,
      home: Scaffold(

       appBar: AppBar(
         backgroundColor:  Color(0xfff48020),
          title: const Text(appTitle),
        ),
        body:  SignupForm(),
      ),
    );
  }
}

// Create a Form widget.
class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}


class SignupFormState extends State<SignupForm> {

  final _formKey = GlobalKey<FormState>();
  LoginBloc _loginBloc = LoginBloc();

  User user = User();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [

              //-

              const SizedBox(
                height: 10,
              ),

              const Text(
                "User Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              TextFormField(
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "username",
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    fillColor: const Color(
                      0xfff3f3f4,
                    ),
                    filled: true,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  onChanged: (newText) { user.username = newText; }
              ),

              const SizedBox(
                height: 10,
              ),
              const Text(
                "Mobile Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              TextFormField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    fillColor: const Color(
                      0xfff3f3f4,
                    ),
                    filled: true,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    return null;
                  },
                  onChanged: (newText) { user.mobile = newText; }
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Email id",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              TextFormField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Email",
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    fillColor: const Color(
                      0xfff3f3f4,
                    ),
                    filled: true,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  onChanged: (newText) { user.email = newText; }
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              TextFormField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "password",
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    fillColor: const Color(
                      0xfff3f3f4,
                    ),
                    filled: true,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onChanged: (newText) { user.pswd = newText; }
              ),

              const SizedBox(
                height: 10,
              ),
              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "password",
                  suffixIcon: const Icon(
                    Icons.visibility,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  fillColor: const Color(
                    0xfff3f3f4,
                  ),
                  filled: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter confirm password';
                  }
                  return null;
                },
                // onChanged: (newText) { user.pswd = newText; }
              ),
              //--
              const SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff48020)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginBloc.makeGetRequest(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Register Now'),
                  ),
                  Container(height: 5.0),//
                ],
              ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
             child:Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Already have an account ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Color(
                          0xFF0389F6,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
        ),
        ],
      ),
      ),

    );
  }
  Future<void> makeGetRequest() async {
    // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
    print('Param $user');
    final url = Uri.parse('$urlPrefix/CustomerRegister.aspx?$user');
    http.Response response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
  }
}