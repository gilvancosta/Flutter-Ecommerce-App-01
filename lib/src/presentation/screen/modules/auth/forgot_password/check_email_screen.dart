// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/avatar_widget.dart';
import '../../../../widgets/home_header.dart';

class CheckEmailScreen extends ConsumerStatefulWidget {
  final String email;
  const CheckEmailScreen({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<CheckEmailScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState extends ConsumerState<CheckEmailScreen> {
  int _countSend = 0;

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);
    // final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(
              name: '',
              mensagem: 'Acesse seu e-mail',
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
                    widget.email,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Siga as Instruções',
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
                    onPressed: () {
                      appRouter.pop();
                    },
                    child: const Text('Voltar para o Login'),
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
