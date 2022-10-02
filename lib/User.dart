class User {
  String username= '';
  String mobile= '';
  String email= '';
  String pswd= '';
  String lati= '0';
  String longi= '0';
  @override
  String toString() {
    return 'username=$username&mobile=$mobile&email=$email&pswd=$pswd&lati=$lati&longi=$longi';
  }
}