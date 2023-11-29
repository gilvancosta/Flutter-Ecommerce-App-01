import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/users/user_register/user_register_repository.dart';
import '../../domain/repositories/users/user_register/user_register_repository_impl.dart';
import '../../domain/services/user_register/user_register_service.dart';
import '../../domain/services/user_register/user_register_service_impl.dart';
import '../fp/either.dart';
import '../restClient/rest_client.dart';
import '../ui/barbershop_nav_global_key.dart';

import '../../domain/repositories/users/user_login/user_login_repository.dart';
import '../../domain/repositories/users/user_login/user_login_repository_impl.dart';

import '../../domain/services/user_login/user_login_service.dart';
import '../../domain/services/user_login/user_login_service_impl.dart';

import '../../domain/repositories/product/product_repository.dart';
import '../../domain/repositories/product/product_repository_impl.dart';

import '../../domain/entities/barbershop_model.dart';
import '../../domain/entities/product_model.dart';

import '../../domain/repositories/barbershop/barbershop_repository.dart';
import '../../domain/repositories/barbershop/barbershop_repository_impl.dart';

import '../../domain/repositories/schedule/schedule_repository.dart';
import '../../domain/repositories/schedule/schedule_repository_impl.dart';

import '../../domain/services/product/product_service.dart';
import '../../domain/services/product/product_service_impl.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;

// == User Login ==
@Riverpod(keepAlive: true)
UserLoginRepository userLoginRepository(UserLoginRepositoryRef ref) => UserRepositoryImpl(firebaseAuth: ref.read(firebaseAuthProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) => UserLoginServiceImpl(userLoginRepository: ref.read(userLoginRepositoryProvider));

// == User Register ==
@Riverpod(keepAlive: true)
UserRegisterRepository userRegisterRepository(UserRegisterRepositoryRef ref) => UserRegisterRepositoryImpl(firebaseAuth: ref.read(firebaseAuthProvider));

@Riverpod(keepAlive: true)
UserRegisterService userRegisterService(UserRegisterServiceRef ref) => UserRegisterServiceImpl(userRegisterRepository: ref.read(userRegisterRepositoryProvider));

// == RestClientApp ==

@Riverpod(keepAlive: true)
RestClientApp restClientApp(RestClientAppRef ref) => RestClientApp();

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) =>
    ProductRepositoryImpl(restClient: ref.read(restClientAppProvider));

@Riverpod(keepAlive: true)
ProductService productService(ProductServiceRef ref) =>
    ProductServiceImpl(productRepository: ref.read(productRepositoryProvider));

@Riverpod(keepAlive: true)
Future<ProductModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(productRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientAppProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final productModel = await ref.watch(getMeProvider.future);

  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarbershop(productModel);

  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);
  Navigator.of(BarbershopNavGlobalKey.instance.navkey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}



@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.read(restClientAppProvider));

/// Rodar o comando abaixo
///  dart run build_runner watch -d
/// 