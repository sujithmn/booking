class Address {
  String name= '';
  String mobile= '';
  String email= '';
  String address= '';
  String state= '';
  String city= '';
  String pin='';
  @override
  String toString() {
    return 'name=$name&mobile=$mobile&email=$email&address=$address&state=$state&city=$city&pin=$pin';
  }
}