import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/users/user_login/user_login_repository.dart';
import '../user_login/user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserLoginRepository _userLoginRepository;

  UserLoginServiceImpl({
    required UserLoginRepository userLoginRepository,
  }) : _userLoginRepository = userLoginRepository;

  @override
  Future<User?> login(String email, String password) =>
      _userLoginRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) =>
      _userLoginRepository.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _userLoginRepository.googleLogin();

  @override
  Future<void> logout() => _userLoginRepository.logout();

  @override
  Future<void> updateDisplayName(String name) =>
      _userLoginRepository.updateDisplayName(name);
}
