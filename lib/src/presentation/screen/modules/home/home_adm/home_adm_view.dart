import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/ui/barbershop_icons.dart';
import '../../../../../core/widgets/barbershop_loader.dart';
import '../../../../widgets/home_header.dart';
import 'provider/home_adm_state.dart';
import 'provider/home_adm_vm.dart';
import 'widgets/home_employee_tile.dart';

class HomeAdmView extends ConsumerWidget {
  const HomeAdmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeADMVMProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/employee/register');
          ref.invalidate(getMeProvider);
          ref.invalidate(homeADMVMProvider);
        },
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addCustomer,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: homeState.when(
        loading: () => const BarbershopLoader(),
        error: (e, s) {
          log('UI Erro ao buscar colaboradores', error: e, stackTrace: s);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Erro ao carregar página.',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(homeADMVMProvider.notifier).logout();
                  },
                  child: const Text('Deslogar'),
                ),
              ],
            ),
          );
        },
        data: (HomeADMState data) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(
                name: 'Administrador',
                mensagem: 'Atualize seu Cadastro',
                hideFilter: false,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: data.employees.length,
                (context, index) => HomeEmployeeTile(
                  employee: data.employees[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
