// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/helpers/messages.dart';
import '../../../../../core/providers/application_providers.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/widgets/avatar_widget.dart';
import '../../../../widgets/home_header.dart';

import 'provider/email_verification_vm.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  int _countSend = 0;

  @override
  Widget build(BuildContext context) {
    final EmailVerificationVm(:sendEmailVerification) =
        ref.watch(emailVerificationVmProvider.notifier);
    final userCredential = ref.watch(firebaseAuthProvider).currentUser;

    // final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(
              name: userCredential != null
                  ? userCredential.displayName.toString()
                  : 'Cliente',
              mensagem: 'Verifique seu e-mail',
              hideFilter: true,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const AvatarWidget.withoutButton(),
                  const SizedBox(height: 24),
                  const Text(
                    'Enviamos uma mensagem para:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    userCredential != null
                        ? userCredential.email.toString()
                        : 'Não informado',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Confirme o email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () async {
                      try {
                        await ref
                            .read(firebaseAuthProvider)
                            .currentUser
                            ?.reload();

                        final user = ref.read(firebaseAuthProvider).currentUser;

                        final emailVerified2 =
                            user != null ? user.emailVerified : false;

                        if (emailVerified2) {
                          Navigator.of(context).pushReplacementNamed(
                              AppRoutes.customerRegistrationScreen);
                        } else {
                          Messages.showInfo(
                              'O email ainda não foi confirmado', context);
                        }
                      } catch (e) {
                        Messages.showError(
                            'Não foi possível verificar, faça login novamente',
                            context);
                      }

                      // print('CCCCCCC userCredential: $userCredential');
                    },
                    child: const Text('Já Confirmei'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      // ignore: avoid_print
                      //  print('dddddddddddcountSend ; $_countSend');

                      if (_countSend == 0) {
                        _countSend++;
                        await sendEmailVerification();

                        Messages.showInfo(
                            'Mensagem de Confirmação Enviada', context);
                      } else {
                        Messages.showError(
                            'Aguarde 60 segundos ou faça login novamente',
                            context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('Enviar Novamente'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
