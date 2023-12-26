// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helpers/messages.dart';
import '../../../core/router/app_router.dart';

import 'splash_vm.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  final _animationDuration = const Duration(milliseconds: 3000);
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => _scale * 100;
  double get _logoAnimationHeight => _scale * 120;

  var endAnimation = false;
  Timer? redirectTimer;



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);  


  void _redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(
        const Duration(milliseconds: 300),
        () => _redirect(routeName),
      );
    } else {
      redirectTimer?.cancel();
      appRouter.pushReplacement(routeName);
    }
  }

    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          _redirect('/login');
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              _redirect('/adm');
              break;
            case SplashState.loggedCustomer:
              _redirect('/customer-registration');
              break;
            case _:
              _redirect('/login');
              break;
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundPage),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
              duration: _animationDuration,
              opacity: _animationOpacityLogo,
              curve: Curves.easeIn,

              //-----------------
              onEnd: () {
                setState(() {
                  endAnimation = true;
                });
              },

              //---------------------
              child: AnimatedContainer(
                duration: _animationDuration,
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  ImageConstants.imageLogoSplash,
                  fit: BoxFit.cover,
                ),
              )),
        ), // tive que adicionar para a imagem aparecer
      ),
    );
  }
}
