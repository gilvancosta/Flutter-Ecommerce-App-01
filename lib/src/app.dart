import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/constants.dart';
import 'core/routes/app_routes.dart';
import 'core/ui/app_theme.dart';

import 'core/ui/theme_changer_provider.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoutes = ref.watch(appRoutesProvider);  
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      title: CompanyConstants.CompanyName,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme,
      routerConfig: appRoutes,
    
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
