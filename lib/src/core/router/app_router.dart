// ignore_for_file: avoid_print
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/views/app_home/home_page.dart';
import '../../presentation/views/modules/auth/login/login_page.dart';
import '../../presentation/views/modules/auth/register/barbershop/barbershop_register_page.dart';
import '../../presentation/views/modules/auth/register/user/user_register_page.dart';
import '../../presentation/views/modules/auth/verification/email_verification_screen.dart';
import '../../presentation/views/modules/customer/registration/customer_registration_screen.dart';
import '../../presentation/views/modules/home/home_adm/home_adm_view.dart';
import '../../presentation/views/modules/home/home_customer/home_customer_view.dart';

import '../../presentation/views/splash/splash_page.dart';

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
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register/user',
      builder: (context, state) => const UserRegisterPage(),
    ),
    GoRoute(
      path: '/register/barbershop',
      builder: (context, state) => const BarbershopRegisterPage(),
    ),
    GoRoute(
      path: '/home-customer',
      builder: (context, state) => const HomeCustomerView(),
    ),
    GoRoute(
      path: '/adm',
      builder: (context, state) => const HomeAdmView(),
    ),
    GoRoute(
      path: '/email-verification',
      builder: (context, state) => const EmailVerificationScreen(),
    ),
    GoRoute(
      path: '/customer-registration',
      builder: (context, state) => const CustomerRegistrationScreen(),
    ),
  ]);
}
