import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_messages.dart';
import '../../../../../core/ui/helpers/messages.dart';
import '../../../../../core/widgets/TextFormField/my_textformfield_email.dart';
import '../../../../../core/widgets/TextFormField/my_textformfield_password.dart';
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

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          break;
        case LoginState(status: LoginStateStatus.customerLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/customer', (route) => false);
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
              image: AssetImage(ImageConstants.backgroundChair),
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
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                if (emailEC.text.isNotEmpty) {
                                  // Recuperar senha
                                  //  context
                                  //     .read<LoginController>()
                                  //     .forgotPassword(_emailEC.text);
                                } else {
                                  _emailFocus.requestFocus();
                                  AppMessages.of(context).showError(
                                      'Digite um e-mail para recuperar a senha');
                                }
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
                                    // context.read<LoginController>().googleLogin();
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
                                        appRouter.push('/auth/register/user');

                                        //  Navigator.of(context)
                                        // .pushNamed('/auth/register/user');
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
                              .pushNamed('/auth/register/user'),
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
