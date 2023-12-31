import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';

import '../../models/user_model.dart';

abstract interface class PersonRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String name, String email, String password}) userData,
  );

  Future<Either<RepositoryException, List<UserModel>>> getCustomers(
    int barbershopId,
  );

  Future<Either<RepositoryException, Nil>> registerAdmAsCustomer(
    ({
      List<String> workdays,
      List<int> workHours,
    }) personModel,
  );

  Future<Either<RepositoryException, Nil>> registerCustomer(
    ({
      int barbershopId,
      String name,
      String email,
      String password,
      List<String> workdays,
      List<int> workHours,
    }) personModel,
  );
}
