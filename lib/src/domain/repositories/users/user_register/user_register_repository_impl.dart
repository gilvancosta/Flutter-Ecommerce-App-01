// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exceptions/app_auth_exception.dart';

import 'user_register_repository.dart';

class UserRegisterRepositoryImpl implements UserRegisterRepository {
  final FirebaseAuth _firebaseAuth;

  UserRegisterRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String nome, String email, String password) async {
   try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      // account-exists-with-different-credential
      // email-already-exists
      if (e.code == 'email-already-in-use') {
        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AppAuthException(message: 'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          throw AppAuthException(message: 'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar !!!');
        }
      } else {
        throw AppAuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }


}
