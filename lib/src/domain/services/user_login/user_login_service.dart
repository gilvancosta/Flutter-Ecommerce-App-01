import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';


abstract class UserLoginService {


  Future<Either<ServiceException, Nil>> sendEmailVerification();

  Future<Either<ServiceException, Nil>>login(String email, String password);


  
  Future<void> forgotPassword(String email);
  Future<Either<ServiceException, Nil>>googleLogin();
  Future<void> logout();
  Future<void> updateDisplayName(String name);
}
