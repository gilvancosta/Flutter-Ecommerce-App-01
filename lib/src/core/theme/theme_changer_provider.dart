import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';



// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Un simple boolean
final isDarkModeProvider2 = StateProvider((ref) => false);

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0);




// Un objeto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);


// Controller ou Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  
  // STATE = Estado = new AppTheme();
  ThemeNotifier(): super( AppTheme() );


  void toggleDarkmode() {
    state = state.copyWith( isDarkmode: !state.isDarkmode  );
  }

  void changeColorIndex( int colorIndex) {
    state = state.copyWith( selectedColor: colorIndex );
  }


}
