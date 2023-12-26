import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/local_storage_keys.dart';

import '../../../core/exceptions/auth_exception.dart';
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

  Future<Either<ServiceException, Nil>> login(String email, String password) async {

    final loginResult = await _userLoginRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException(message: exception.message)),
          AuthUnauthorizedException() => Failure(ServiceException(message: exception.message)),
        };
    }
  }



  @override
  Future<Either<ServiceException, Nil>> forgotPassword(String email) async {
    try {
      await _userLoginRepository.forgotPassword(email);
      return Success(nil);
    } on ServiceException catch (e, s) {
      log('Erro no reset da password', error: e, stackTrace: s);

      return Failure(
        ServiceException(
          message: e.message,
        ),
      );
    }
  }

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
