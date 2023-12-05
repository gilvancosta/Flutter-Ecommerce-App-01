import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/ui/widgets/avatar_widget.dart';
import '../../../../../core/ui/widgets/barbershop_loader.dart';
import '../../../../../domain/models/user_model.dart';
import '../widgets/home_header.dart';
import 'provider/home_customer_provider.dart';

class HomeCustomerView extends ConsumerWidget {
  const HomeCustomerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        error: (e, s) {
          const errorMessage = 'Erro ao carregar página';
          log(errorMessage, error: e, stackTrace: s);
          return const Center(
            child: Text(errorMessage),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (user) {
          final UserModel(:id, :displayName) = user;
          return CustomScrollView(
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
                        displayName.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: 108,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorsConstants.brow),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final totalAsync = ref.watch(
                                  getTotalSchedulesTodayProvider(id),
                                );

                                return totalAsync.when(
                                  error: (e, s) {
                                    const errorMessage =
                                        'Erro ao carregar total de agendamentos';
                                    return const Text(errorMessage);
                                  },
                                  loading: () => const BarbershopLoader(),
                                  skipLoadingOnRefresh: false,
                                  data: (totalScheduule) {
                                    return Text(
                                      '$totalScheduule',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        color: ColorsConstants.brow,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const Text(
                              'Hoje',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorsConstants.brow,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(
                            '/schedule',
                            arguments: user,
                          );
                          ref.invalidate(getTotalSchedulesTodayProvider(id));
                        },
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
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/employee/schedule',
                            arguments: user,
                          );
                        },
                        child: const Text('VER AGENDA'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
