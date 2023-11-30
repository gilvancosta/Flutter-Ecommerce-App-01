import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/local_storage_keys.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/pessoa/person_repository.dart';
import 'person_service.dart';

class PersonServiceImpl implements PersonService {
  final PersonRepository personRepository;
  PersonServiceImpl({
    required this.personRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await personRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao realizar login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou senha inválidos')),
        };
    }
  }
}
