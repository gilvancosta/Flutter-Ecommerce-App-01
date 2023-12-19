// ignore_for_file: avoid_print

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/fp/either.dart';
import '../../../../../core/providers/application_providers.dart';
import 'forgot_password_state.dart';

part 'forgot_password_vm.g.dart';

@riverpod
class ForgotPasswordVm extends _$ForgotPasswordVm {
  @override
  ForgotPasswordStatus build() => ForgotPasswordStatus.initial;

  Future<void> forgotPassword(String email) async {
    // final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);
    final user = await loginService.forgotPassword(email);

    switch (user) {
      case Success():
        state = ForgotPasswordStatus.success;
        print('Success():');
      //  ref.invalidate(getMeProvider);
      case Failure():
        print('Failure():');
        state = ForgotPasswordStatus.error;
    }

    // loaderHandle.close();
  }
}
