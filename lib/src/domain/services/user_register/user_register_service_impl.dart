import 'dart:developer';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/user_register/user_register_repository.dart';
import 'user_register_service.dart';

class UserRegisterServiceImpl implements UserRegisterService {
  final UserRegisterRepository _userRegisterRepository;

  UserRegisterServiceImpl({
    required UserRegisterRepository userRegisterRepository,
  }) : _userRegisterRepository = userRegisterRepository;

  @override
  Future<Either<ServiceException, Nil>> register(
      ({String name, String email, String password}) userData) async {

    try {
      await _userRegisterRepository.register(userData);
      return Success(nil);
    } on RepositoryException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(
        ServiceException(
          message: e.message,
        ),
      );
    }
  }


}
