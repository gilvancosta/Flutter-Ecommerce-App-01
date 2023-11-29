import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/users/user_register/user_register_repository.dart';
import 'user_register_service.dart';


class UserRegisterServiceImpl implements UserRegisterService {
  final UserRegisterRepository _userRegisterRepository;


  UserRegisterServiceImpl({
    required UserRegisterRepository userRegisterRepository,
  }) : _userRegisterRepository = userRegisterRepository;

 @override
  Future<User?> register(String name, String email, String password) => _userRegisterRepository.register(name, email, password);


}