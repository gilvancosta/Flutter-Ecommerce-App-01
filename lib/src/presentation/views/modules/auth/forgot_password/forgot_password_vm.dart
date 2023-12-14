// ignore_for_file: avoid_print
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/exceptions/service_exception.dart';
import '../../../../../core/fp/either.dart';
import '../../../../../core/providers/application_providers.dart';
import 'forgot_password_state.dart';

part 'forgot_password_vm.g.dart';

@riverpod
class ForgotPasswordVm extends _$ForgotPasswordVm {
  @override
  ForgotPasswordState build() => ForgotPasswordState.initial();

  Future<void> forgotPassword() async {

     final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);
    final user = await loginService.forgotPassword;

    switch (user) {
      case Success():
        state = state.copyWith(status: ForgotPasswordStatus.customerLogin);
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: ForgotPasswordStatus.error,
          errorMessage: () => message,
        );
    }

      loaderHandle.close();
  }

 


}
