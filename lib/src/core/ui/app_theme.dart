import 'package:flutter/material.dart';

import '../constants/constants.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  static const defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(
      color: ColorsConstants.grey,
    ),
  );

  ThemeData getTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsConstants.brow),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black,
        fontFamily: FontConstants.fontFamily,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder.copyWith(
          borderSide: const BorderSide(color: ColorsConstants.red)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorsConstants.brow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    fontFamily: FontConstants.fontFamily,
  );

  AppTheme copyWith({int? selectedColor, bool? isDarkmode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
