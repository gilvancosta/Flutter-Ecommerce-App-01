import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_changer_provider.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

   // final isDarkmode = ref.watch(isDarkModeProvider2);
   // final selectedColor = ref.watch(selectedColorProvider);

      final AppTheme appTheme = ref.watch( themeNotifierProvider );

    return MaterialApp.router(
      title: 'Riverpod Providers',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    //  theme: AppTheme(selectedColor: selectedColor, isDarkmode: isDarkmode).getTheme(),
      theme: appTheme.getTheme(),

    );
  }
}
