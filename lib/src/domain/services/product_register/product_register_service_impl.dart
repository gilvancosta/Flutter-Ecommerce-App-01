
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/product/product_repository.dart';
import '../product/product_service.dart';
import 'product_register_service.dart';

class ProductRegisterServiceImpl implements ProductRegisterService {
  final ProductRepository productRepository;
  final ProductService productService;
  ProductRegisterServiceImpl({
    required this.productRepository,
    required this.productService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(({String email, String name, String password}) productData) async {
    final registerResult = await productRepository.registerAdmin(productData);

    switch (registerResult) {
      case Success():
        return productService.execute(productData.email, productData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
