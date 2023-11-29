
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../entities/product_model.dart';

abstract interface class ProductRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, ProductModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String name, String email, String password}) userData,
  );

  Future<Either<RepositoryException, List<ProductModel>>> getEmployees(
    int barbershopId,
  );

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
    ({
      List<String> workdays,
      List<int> workHours,
    }) productModel,
  );

  Future<Either<RepositoryException, Nil>> registerEmployee(
    ({
      int barbershopId,
      String name,
      String email,
      String password,
      List<String> workdays,
      List<int> workHours,
    }) productModel,
  );
}
