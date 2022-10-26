
import 'bloc.dart';
import 'globals.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:booking/model/login_user.dart';
import 'package:booking/model/User.dart';

class LoginBloc extends Bloc {

  final loginController = StreamController<String>.broadcast();

  Future<void> userLogin(LoginUser login) async {
    print('Param $urlPrefix/customerlogin.ashx?$login');
    final url = Uri.parse('$urlPrefix/customerlogin.ashx?$login');
    http.Response response = await http.get(url);
    debugResponse(response);
    if(response.statusCode==200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      loginController.sink.add(user['UserName']);
    }else{
      throw Exception("Invalid credentials");
    }
  }

  Future<void> makeGetRequest(User user) async {
    // String params = 'username=$user.username&mobile=$user.mobile&email=$user.email&pswd=$user.pswd&lati=$user.lati&longi=$user.longi';
    print('Param $user');
    final url = Uri.parse('$urlPrefix/CustomerRegister.aspx?$user');
    http.Response response = await http.get(url);
    debugResponse(response);
    if(response.statusCode==200) {

    }else{
      throw Exception("User not saved.");
    }
  }

  debugResponse(http.Response response){
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
  }

  @override
  void dispose() {
    loginController.close();
  }
}