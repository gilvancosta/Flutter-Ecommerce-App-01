// ignore_for_file: avoid_print
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/modules/auth/login/login_page.dart';
import '../../presentation/pages/modules/auth/register/barbershop/barbershop_register_page.dart';
import '../../presentation/pages/modules/auth/register/user/user_register_page.dart';
import '../../presentation/pages/splash/splash_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/auth/register/user',
      builder: (context, state) => const UserRegisterPage(),
    ),
    GoRoute(
      path: '/auth/register/barbershop',
      builder: (context, state) => const BarbershopRegisterPage(),
    ),
  ]);
}
