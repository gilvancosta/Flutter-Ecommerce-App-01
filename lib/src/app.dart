import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app_01/src/presentation/screen/modules/auth/forgot_password/forgot_password_screen.dart';
import 'package:flutter_ecommerce_app_01/src/presentation/screen/modules/customer/registration/customer_registration_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/constants.dart';

import 'core/router/app_routes.dart';
import 'core/ui/app_theme.dart';

import 'core/ui/theme_changer_provider.dart';

import 'presentation/screen/app_home/home_page.dart';
import 'presentation/screen/modules/auth/forgot_password/check_email_screen.dart';
import 'presentation/screen/modules/auth/login/login_page.dart';
import 'presentation/screen/modules/auth/register/barbershop/barbershop_register_page.dart';
import 'presentation/screen/modules/auth/register/user/user_register_page.dart';
import 'presentation/screen/modules/auth/verification/email_verification_screen.dart';
import 'presentation/screen/modules/home/home_adm/home_adm_view.dart';
import 'presentation/screen/modules/home/home_customer/home_customer_view.dart';
import 'presentation/screen/splash/splash_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: CompanyConstants.CompanyName,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme,
      initialRoute: AppRoutes.splashPage,
      routes: {
        AppRoutes.splashPage: (ctx) => const SplashPage(),
        AppRoutes.homePage: (ctx) => const HomePage(),
        AppRoutes.loginPage: (ctx) => const LoginPage(),
        AppRoutes.userRegisterPage: (ctx) => const UserRegisterPage(),
        AppRoutes.barbershopRegisterPage: (ctx) =>
            const BarbershopRegisterPage(),
        AppRoutes.homeCustomerView: (ctx) => const HomeCustomerView(),
        AppRoutes.homeAdmView: (ctx) => const HomeAdmView(),
        AppRoutes.emailVerificationScreen: (ctx) =>
            const EmailVerificationScreen(),
        AppRoutes.customerRegistrationScreen: (ctx) =>
            const CustomerRegistrationScreen(),
        AppRoutes.forgotPasswordPage: (ctx) => const ForgotPasswordPage(),
        AppRoutes.checkEmailScreen: (ctx) {
          final args =
              ModalRoute.of(ctx)?.settings.arguments as Map<String, dynamic>;
          final email = args['email'] as String;

          return CheckEmailScreen(email: email);
        },
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
    );
  }
}
