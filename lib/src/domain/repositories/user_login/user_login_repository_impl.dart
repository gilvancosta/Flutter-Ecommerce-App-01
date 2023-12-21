// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/exceptions/app_auth_exception.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';

import '../../../core/fp/nil.dart';
import 'user_login_repository.dart';

class UserRepositoryImpl implements UserLoginRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<RepositoryException, Nil>> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      }
      return Success(Nil());
    } on Exception catch (e, s) {
      log('Erro ao verificar email', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao verificar email'));
    }
  }

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final accessToken = await userCredential.user?.getIdToken();
      print(' EEEEEEEE 1 --> $accessToken');

      return Success(accessToken.toString());

      // } on PlatformException catch (e, s) {
      //print(' EEEEEEEE 1 --> ${e.code}');
      // print(' SSSSSSSS 1 --> $s');
      // throw AppAuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(' EEEEEEEE 2 --> ${e.code}');
      print(' SSSSSSSS 3 --> $s');

      if (e.code == 'invalid-credential') {
        return Failure(AuthError(message: 'Login ou senha inválidos'));
      } else if (e.code == 'wrong-password') {
        return Failure(AuthError(message: 'Senha não confere'));
      } else if (e.code == 'invalid-email') {
        return Failure(AuthError(message: 'Email inválido'));
      } else {
        return Failure(AuthError(message: 'Erro ao realizar login'));
      }
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> forgotPassword(String email) async {
    // print(' --- AAAAAAAAA 1 --- $email');
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      //   print(' --- BBBBBBBBBB 2 --- $email');
      return Success(Nil());
    } on Exception catch (e, s) {
      log('Erro no reset da senha', error: e, stackTrace: s);
      // print(' EEEEEEEE 1 --> $e - $s');
      return Failure(RepositoryException(message: 'Erro no reset da senha'));
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AppAuthException(
              message:
                  'Você utilizou o e-mail antes para cadastro na APP, caso tenha esquecido sua senha por favor clique no link esqueci minha senha');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      }
    } on FirebaseException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AppAuthException(
            message:
                'Login inválido voce se registrou no APP com os seguintes provedores: ${loginMethods?.join(',')}');
      } else {
        throw AppAuthException(message: 'Erro ao realizar login');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
