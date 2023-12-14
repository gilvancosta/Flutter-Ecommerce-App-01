import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/user_register/user_register_repository.dart';
import '../user_register/user_register_service.dart';
import 'user_register_adm_service.dart';
         
final class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRegisterRepository _userRegisterRepository;
  final UserRegisterService _userRegisterService;

  UserRegisterAdmServiceImpl({
    required UserRegisterRepository userRegisterRepository,
    required UserRegisterService userRegisterService,
  })  : _userRegisterRepository = userRegisterRepository,
        _userRegisterService = userRegisterService;

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult =
        await _userRegisterRepository.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return _userRegisterService.register(userData);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }




  
}
