// ignore_for_file: avoid_print

import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../../core/exceptions/service_exception.dart';
import '../../../../../../core/fp/either.dart';
import '../../../../../../core/providers/application_providers.dart';

import 'email_verification_state.dart';


part 'email_verification_vm.g.dart';

@riverpod
class EmailVerificationVm extends _$EmailVerificationVm {
  @override
  EmailVerificationState build() => EmailVerificationState.initial();

  Future<void> googleLogin() async {
     final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);
    final user = await loginService.sendEmailVerification();


    //_userService.logout();

    switch (user) {
      case Success():
        state = state.copyWith(
                status: VerificationState.success);
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: VerificationState.error,
          errorMessage: () => message,
        );
    }

      loaderHandle.close();
  }


}

