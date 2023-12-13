import 'dart:io';

enum CustomerStatusApp { signup, login }

class CustomerModel {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  CustomerStatusApp _statusApp = CustomerStatusApp.login;

bool get isLogin => _statusApp == CustomerStatusApp.login;
bool get isSignup => _statusApp == CustomerStatusApp.signup;

void toggleAuthMode() {
  _statusApp = isLogin ? CustomerStatusApp.signup : CustomerStatusApp.login;

}

}
