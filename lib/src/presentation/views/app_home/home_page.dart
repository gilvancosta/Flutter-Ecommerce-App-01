import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation_drawer/navigation_drawer_widget.dart';
import '../../../core/ui/theme_changer_provider.dart';
import 'widgets/list_view_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // static const String name = 'home_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              print('isDarkMode: $isDarkMode');
              //ref.read(isDarkModeProvider2.notifier).update((state) => !state);
              ref.read(themeNotifierProvider.notifier).toggleDarkmode();
            },
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      drawer: NavigationDrawerWidget(),
      body: const ListViewWidget(),
    );
  }
}
