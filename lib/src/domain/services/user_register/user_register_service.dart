
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';


abstract interface class UserRegisterService {
  Future<Either<ServiceException, Nil>> register(
      ({String name, String email, String password}) userData);
}
