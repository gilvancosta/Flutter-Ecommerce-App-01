import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/barbershop_model.dart';
import '../../domain/model/user_model.dart';
import '../../domain/repositories/barbershop/barbershop_repository.dart';
import '../../domain/repositories/barbershop/barbershop_repository_impl.dart';
import '../../domain/repositories/schedule/schedule_repository.dart';
import '../../domain/repositories/schedule/schedule_repository_impl.dart';
import '../../domain/repositories/user/user_repository.dart';
import '../../domain/repositories/user/user_repository_impl.dart';
import '../../domain/services/user_login/user_login_service.dart';
import '../../domain/services/user_login/user_login_service_impl.dart';
import '../fp/either.dart';
import '../restClient/rest_client.dart';
import '../ui/barbershop_nav_global_key.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) => UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)



Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) => BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) { Success(value: final barbershop) => barbershop, Failure(:final exception) => throw exception };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);
  Navigator.of(BarbershopNavGlobalKey.instance.navkey.currentContext!).pushNamedAndRemoveUntil('/auth/login', (route) => false);
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) => ScheduleRepositoryImpl(restClient: ref.read(restClientProvider));

/// Rodar o comando abaixo
///  dart run build_runner watch -d
/// 