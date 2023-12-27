// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/screen/app_home/home_page.dart';
import '../../presentation/screen/modules/auth/forgot_password/check_email_screen.dart';
import '../../presentation/screen/modules/auth/forgot_password/forgot_password_screen.dart';
import '../../presentation/screen/modules/auth/login/login_page.dart';
import '../../presentation/screen/modules/auth/register/barbershop/barbershop_register_page.dart';
import '../../presentation/screen/modules/auth/register/user/user_register_page.dart';
import '../../presentation/screen/modules/auth/verification/email_verification_screen.dart';
import '../../presentation/screen/modules/customer/registration/customer_registration_screen.dart';
import '../../presentation/screen/modules/home/home_adm/home_adm_view.dart';
import '../../presentation/screen/modules/home/home_customer/home_customer_view.dart';
import '../../presentation/screen/splash/splash_page.dart';

part 'app_routes.g.dart';

@riverpod
GoRouter appRoutes(AppRoutesRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
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
        // builder: (context, state) => const LoginPage(),
        // dessa forma o loginPage não é recriado toda vez que é chamado
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('LoginPage'),
          child: LoginPage(),
         // fullscreenDialog: true,
        ),
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
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/check-email/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return CheckEmailScreen(email: email);
        },
      ),
    ],
  );
}
