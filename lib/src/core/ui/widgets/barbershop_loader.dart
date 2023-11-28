
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


import '../../constants/constants.dart';

class BarbershopLoader extends StatelessWidget {
  const BarbershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color: ColorsConstants.brow,
      size: 60,
    );
  }
}
