import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/exceptions/service_exception.dart';
import '../../../../../core/fp/either.dart';
import '../../../../../core/providers/application_providers.dart';
//import '../../../../../domain/model/user_model.dart';

import '../../../../../domain/models/user_model.dart';
import 'login_state.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.login(email, password);

    switch (result) {
      case Success():

        /// buscar dados do usuário logado
        /// fazer o switch para o tipo de usuário
        /// invalidando os caches para evitar o login com o usuário errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelCustomer():
            state = state.copyWith(status: LoginStateStatus.customerLogin);
        }
        break;

      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
