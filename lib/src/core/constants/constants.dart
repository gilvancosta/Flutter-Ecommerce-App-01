import 'package:flutter/material.dart';


sealed class CompanyConstants {
  static const String CompanyName = 'Atacadão Eletrônicos';
}



sealed class FontConstants {
  static const String fontFamily = 'Poppins';
}

sealed class ColorsConstants {
  static const brow = Color(0xffff6a14);
  static const grey = Color(0xff0033ff);
  static const greyLight = Color(0xFFE9E2E9);
  static const red = Color(0xFFEB1212);
}

sealed class ImageConstants {
  static const backgroundPage = 'assets/images/background_page.jpg';
  static const imageLogo = 'assets/images/imgLogo.png';
  static const imageLogoSplash = 'assets/images/imgLogoSplash.png';
  static const photoURL = 'assets/images/imgLogoSplash.png';
  static const avatar = 'assets/images/avatar.png';
}
