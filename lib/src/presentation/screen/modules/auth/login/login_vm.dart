// ignore_for_file: avoid_print

import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../../../../../core/exceptions/service_exception.dart';
import '../../../../../core/fp/either.dart';
import '../../../../../core/providers/application_providers.dart';
//import '../../../../../domain/model/user_model.dart';

import 'login_state.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> googleLogin() async {
    // final loaderHandle = AsyncLoaderHandler()..start();

    // print('AAAAAAAAAAAAAAAA 1111');

    final loginService = ref.watch(userLoginServiceProvider);

    //  print('AAAAAAAAAAAAAAAA 222222');
    final user = await loginService.googleLogin();

    // print('AAAAAAAAAAAAAAAA 333');

    //_userService.logout();

    switch (user) {
      case Success():
        state = state.copyWith(status: LoginStateStatus.customerLogin);
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }

    // loaderHandle.close();
  }

  Future<void> login(String email, String password) async {
    //  final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.login(email, password);
   // print('AAAAAAAAAAAAAAAA result:  $result');
    switch (result) {
      case Success():
        state = state.copyWith(status: LoginStateStatus.customerLogin);
        break;
      case Failure(exception: ServiceException(:final message)):
       // print('BBBBBBBBB result:  $result - $message');
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    // loaderHandle.close();
  }
}
