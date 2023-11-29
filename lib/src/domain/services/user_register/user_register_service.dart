import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegisterService {
  Future<User?> register(String name, String email, String password);

}


