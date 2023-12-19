// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/router/app_router.dart';

import '../../../../../core/helpers/messages.dart';
import '../../../../widgets/TextFormField/my_textformfield_email.dart';
import '../../../../widgets/TextFormField/my_textformfield_password.dart';

import 'login_state.dart';
import 'login_vm.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final _emailFocus = FocusNode();
  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);

    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    final LoginVm(:googleLogin) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) async {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          appRouter.pushReplacement('/adm');
          break;
        case LoginState(status: LoginStateStatus.customerLogin):

          // atualizar credenciais do usuário do firebird
          // await ref.read(firebaseAuthProvider).currentUser?.reload();
          // final userCredential = ref.watch(firebaseAuthProvider).currentUser;
          final userCredential = ref.read(firebaseAuthProvider).currentUser;
          final emailVerified =
              userCredential != null ? userCredential.emailVerified : false;

          if (emailVerified) {
            appRouter.pushReplacement('/customer-registration');
          } else {
            appRouter.push('/email-verification');
          }

          break;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.backgroundPage),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // -- Logo --
                          Image.asset(ImageConstants.imageLogo),
                          const SizedBox(height: 20),
                          // -- Email --
                          MyTextFormFieldEmail(
                            controller: emailEC,
                            focusNode: _emailFocus,
                          ),
                          const SizedBox(height: 20),
                          // -- Password --
                          MyTextFormFieldPassword(
                            controller: passwordEC,
                          ),

                          // -- Forgot Password --
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                appRouter.push('/forgot-password');
                              },
                              child: const Text(
                                'Esqueceu a Senha?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // -- Login Button --
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              //login(emailEC.text, passwordEC.text);

                              switch (formKey.currentState!.validate()) {
                                case (false):
                                  Messages.showError(
                                      'Preencha os campos corretamente',
                                      context);
                                  break;
                                case true:
                                  login(emailEC.text, passwordEC.text);
                                  break;
                              }
                            },
                            child: const Text('ACESSAR'),
                          ),

                          // -- login com google --
                          const SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                // sign in button Google
                                // O SignInButton  (package) É um widget do pacote flutter_signin_button
                                SignInButton(
                                  Buttons.Google,
                                  text: 'Continue com Google',
                                  padding: const EdgeInsets.all(5),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {
                                    googleLogin();
                                  },
                                ),
                                const SizedBox(height: 20),
                                // or continue with
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Não tem conta?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        appRouter
                                            .pushReplacement('/register/user');

                                        //  Navigator.of(context)
                                        // .pushNamed('/register/user');
                                      },
                                      child: const Text(
                                        'Cadastre-se1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*                    Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed('/register/user'),
                          child: const Text(
                            'Criar Conta',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ) */
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
