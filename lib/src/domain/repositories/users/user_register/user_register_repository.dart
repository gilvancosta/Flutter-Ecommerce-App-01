import '../../../../core/exceptions/repository_exception.dart';
import '../../../../core/fp/either.dart';
import '../../../../core/fp/nil.dart';

abstract class UserRegisterRepository {
  Future<Either<RepositoryException, Nil>> register(
    ({String name, String email, String password}) userData,
  );

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String name, String email, String password}) userData,
  );
}
