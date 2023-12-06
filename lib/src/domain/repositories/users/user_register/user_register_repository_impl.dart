// ignore_for_file: avoid_print

import 'dart:developer' as developer;

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
    ({String name, String email, String password}) userData,
  ) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );

      final userRegister = userCredencial.user;

      await userRegister?.updateDisplayName(userData.name);

      await userCredencial.user?.sendEmailVerification();

      developer.log('data:  $userCredencial', name: 'userCredencial');

      return Success(nil);
    } on FirebaseAuthException catch (e, s) {
      developer.log('Erro ao registrar usuário', error: e, stackTrace: s);

      final loginTypes =
          await _firebaseAuth.fetchSignInMethodsForEmail(userData.email);

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

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String email, String name, String password}) userData,
  ) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );

      developer.log('data:  $userCredencial', name: 'userCredencial');

      return Success(nil);
    } on FirebaseAuthException catch (e, s) {
      developer.log('Erro ao registrar usuário111', error: e, stackTrace: s);

      final loginTypes =
          await _firebaseAuth.fetchSignInMethodsForEmail(userData.email);

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
