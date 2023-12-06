import 'package:flutter/material.dart';
import 'package:asyncstate/asyncstate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/ui/app_theme.dart';

import 'core/ui/theme_changer_provider.dart';
import 'core/widgets/app_loader.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return AsyncStateBuilder(
        customLoader: const AppLoader(),
        builder: (asyncNavigatorObserver) {
          {
            return MaterialApp.router(
              title: 'Atacadão Eletrônicos',
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: appTheme.getTheme,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('pt', 'BR')],
              locale: const Locale('pt', 'BR'),
            );
          }
        });
  }
}
