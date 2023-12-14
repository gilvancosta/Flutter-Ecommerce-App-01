// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/fp/nil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/helpers/messages.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../widgets/TextFormField/my_textformfield_email.dart';
import 'forgot_password_state.dart';
import 'forgot_password_vm.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final emailEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);
    // final userRegisterVm = ref.watch(forgotPasswordVmProvider.notifier);

    ref.listen(
      forgotPasswordVmProvider,
      (_, state) => switch (state) {
        ForgotPasswordStatus.initial => nil,
        ForgotPasswordStatus.success => appRouter.push('/email-verification'),
        ForgotPasswordStatus.error =>
          Messages.showError('Erro ao realizar cadastro', context),
      },
    );

    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    final double firstContainer = (179 / 732) * screenHeight;
    //  final double voltarButtonWidth = (202 / 412) * screenWidth;
    //  final double voltarButtonHeight = (37 / 732) * screenHeight;
    //  final double enviarButtonWidth = (74 / 412) * screenWidth;
    //  final double enviarButtonHeight = (30 / 732) * screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: firstContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      /*                      Image.asset(
                        ImageConstants.serpentinae,
                      ),
                      const Text('festou\ncadastro'),
                      Image.asset(
                        ImageConstants.serpentinad,
                      ), */
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // -- Email --
                      MyTextFormFieldEmail(
                        controller: emailEC,
                        focusNode: _emailFocus,
                      ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          /*          switch (formKey.currentState?.validate()) {
                            case null || false:
                              Messages.showError(
                                  'Formulário inválido', context);
                            case true:
                              userRegisterVm1.register(
                                name: nameEC.text,
                                email: emailEC.text,
                                password: passwordEC.text,
                              );
                          } */
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Criar Conta'),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
