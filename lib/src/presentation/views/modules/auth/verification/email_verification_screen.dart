import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/widgets/avatar_widget.dart';
import '../../home/widgets/home_header.dart';

class EmailVerificationScreen extends ConsumerWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
    final userCredential = ref.watch(firebaseAuthProvider).currentUser;

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
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('Enviar Novamente'),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {},
                    child: const Text('Já verifiquei'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
