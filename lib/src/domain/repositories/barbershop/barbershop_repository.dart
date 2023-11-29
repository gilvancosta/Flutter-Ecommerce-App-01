
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../entities/barbershop_model.dart';
import '../../entities/product_model.dart';


abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours,
      }) data);

  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(ProductModel productModel);
}
