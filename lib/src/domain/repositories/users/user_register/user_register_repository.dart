import 'package:firebase_auth/firebase_auth.dart';
abstract class UserRegisterRepository {
  Future<User?> register(String nome, String email, String password);
 
}
