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
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const AvatarWidget.withoutButton(),
                  const SizedBox(height: 24),
                  Text(
                    userCredential != null
                        ? userCredential.displayName.toString()
                        : 'Cliente',
                    style: const TextStyle(
                      fontSize: 20,
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
                    child: const Text('AGENDAR CLIENTE'),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {},
                    child: const Text('VER AGENDA'),
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
