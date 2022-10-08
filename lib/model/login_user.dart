class LoginUser {
  String username='';
  String password='';

  String toString() {
    return 'mobile=$username&password=$password';
  }
}