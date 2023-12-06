// ignore_for_file: avoid_print

import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/exceptions/app_auth_exception.dart';
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
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final user = await loginService.googleLogin();

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

    loaderHandle.close();
  }

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    try {
      final loginService = ref.watch(userLoginServiceProvider);

      final result = await loginService.login(email, password);
      print('AAAAAAAAAAAAAAAA result: $result');

      state = state.copyWith(status: LoginStateStatus.customerLogin);
    } on AppAuthException catch (e) {
      state = state.copyWith(
        status: LoginStateStatus.error,
        errorMessage: () => e.message,
      );
    } finally {
      loaderHandle.close();
    }
  }
}
