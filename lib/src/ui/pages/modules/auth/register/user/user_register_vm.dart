import 'package:asyncstate/asyncstate.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../core/fp/either.dart';
import '../../../../../../core/providers/application_providers.dart';
import '../../../../../../domain/services/user_register/user_register_adm_service.dart';
import 'user_register_providers.dart';
part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserRegisterAdmService userRegisterAdmService = ref.read(userRegisterAdmServiceProvider);
    final userData = (
      name: name,
      email: email,
      password: password,
    );
    final registerResult = await userRegisterAdmService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}



/// Rodar o comando abaixo
///  dart run build_runner watch -d
/// 