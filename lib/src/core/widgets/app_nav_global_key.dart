import 'package:flutter/widgets.dart';

final class AppNavGlobalKey {
  AppNavGlobalKey._();

  final navKey = GlobalKey<NavigatorState>();

  static AppNavGlobalKey? _instance;
  static AppNavGlobalKey get instance =>
      _instance ??= AppNavGlobalKey._();
}
