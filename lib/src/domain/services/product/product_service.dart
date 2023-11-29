import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';

abstract interface class ProductService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
