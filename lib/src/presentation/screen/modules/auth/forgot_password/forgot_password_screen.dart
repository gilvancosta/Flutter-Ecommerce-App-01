// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/fp/nil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/helpers/messages.dart';

import '../../../../../core/routes/app_routes.dart';

import '../../../../widgets/TextFormField/my_textformfield_email.dart';

import 'forgot_password_state.dart';
import 'forgot_password_vm.dart';
import 'widgets/header_creeen_widget.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRoutes = ref.watch(appRoutesProvider);
    String emailAtual = '';
    final ForgotPasswordVm(:forgotPassword) =
        ref.watch(forgotPasswordVmProvider.notifier);
    ref.listen(
      forgotPasswordVmProvider,
      (_, state) => switch (state) {
        ForgotPasswordStatus.initial => nil,
        ForgotPasswordStatus.success => appRoutes.pushReplacement('/check-email/$emailAtual'),
        ForgotPasswordStatus.error =>
          Messages.showError('Erro ao enviar Email', context),
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          HeaderScreenWidget(
            name: 'Cliente',
            mensagem: 'Esqueceu sua senha?',
            hideFilter: false,
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                                    switch (formKey.currentState?.validate()) {
                                      case null || false:
                                        Messages.showError(
                                            'Campo inválido', context);

                                      case true:
                                        emailAtual = emailEC.text;
                                        forgotPassword(emailEC.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                  ),
                                  child: const Text('Enviar Email'),
                                ),

                                const SizedBox(height: 20),
                                OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(56),
                                  ),
                                  onPressed: () {
                                     appRoutes.pop();
                                  },
                                  child: const Text('Voltar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
