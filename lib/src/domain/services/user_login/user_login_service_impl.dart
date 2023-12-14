import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/local_storage_keys.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/user_login/user_login_repository.dart';
import '../user_login/user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserLoginRepository _userLoginRepository;

  UserLoginServiceImpl({
    required UserLoginRepository userLoginRepository,
  }) : _userLoginRepository = userLoginRepository;

  @override
  Future<Either<ServiceException, Nil>> sendEmailVerification() async {
    try {
      await _userLoginRepository.sendEmailVerification();
      return Success(nil);
    } on ServiceException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(
        ServiceException(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<ServiceException, Nil>> login(
    String email,
    String password,
  ) async {
    try {
      await _userLoginRepository.login(
        email,
        password,
      );
      return Success(nil);
    } on ServiceException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(
        ServiceException(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) =>
      _userLoginRepository.forgotPassword(email);

  @override
  Future<Either<ServiceException, Nil>> googleLogin() async {
    try {
      await _userLoginRepository.googleLogin();
      return Success(nil);
    } on ServiceException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);

      return Failure(
        ServiceException(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<void> logout() => _userLoginRepository.logout();

  @override
  Future<void> updateDisplayName(String name) =>
      _userLoginRepository.updateDisplayName(name);
}
