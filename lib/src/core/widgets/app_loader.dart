import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/constants.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // O threeArchedCircle é um widget do pacote loading_animation_widget
    // tem o formato de um circulo, com 3 arcos que se movimentam
    return LoadingAnimationWidget.threeArchedCircle(
      color: ColorsConstants.brow,
      size: 60,
    );
  }
}
