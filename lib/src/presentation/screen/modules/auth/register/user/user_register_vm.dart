// ignore_for_file: avoid_print
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../../core/fp/either.dart';
import '../../../../../../core/providers/application_providers.dart';

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
    final userRegisterService = ref.watch(userRegisterServiceProvider);

    //final UserRegisterService userRegisterService = ref.read(userRegisterServiceProvider);

    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final user = await userRegisterService.register(userData).asyncLoader();
    print('Bbbb registerResult: $user');





    switch (user) {
      case Success():
        state = UserRegisterStateStatus.success;
        print('Success():');
      //  ref.invalidate(getMeProvider);
      case Failure():
        print('Failure():');
        state = UserRegisterStateStatus.error;
    }
  }
}

/// Rodar o comando abaixo
///  dart run build_runner watch -d
///
