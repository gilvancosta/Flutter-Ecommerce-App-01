import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';

abstract class UserLoginRepository {
  Future<Either<RepositoryException, Nil>> sendEmailVerification();

  Future<User?> login(String email, String password);

  Future<Either<RepositoryException, Nil>> forgotPassword(String email);

  Future<User?> googleLogin();

  Future<void> logout();

  Future<void> updateDisplayName(String name);
}
