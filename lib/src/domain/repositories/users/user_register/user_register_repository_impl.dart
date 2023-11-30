// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/exceptions/repository_exception.dart';
import '../../../../core/fp/either.dart';
import '../../../../core/fp/nil.dart';
import 'user_register_repository.dart';

class UserRegisterRepositoryImpl implements UserRegisterRepository {
  final FirebaseAuth _firebaseAuth;

  UserRegisterRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<RepositoryException, Nil>> register(
      String nome, String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Success(nil);
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar usuário111', error: e, stackTrace: s);


             final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);



      if (loginTypes.contains('password')) {
        return Failure(
          RepositoryException(
            message: 'E-mail já utilizado, por favor escolha outro e-mail',
          ),
        );
      } else {
        return Failure(
          RepositoryException(
            message:
                'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar !!!',
          ),
        );
      }
    }
  }
}
