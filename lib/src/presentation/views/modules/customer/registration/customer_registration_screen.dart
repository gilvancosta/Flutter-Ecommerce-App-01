import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/avatar_widget.dart';

class CustomerRegistrationScreen extends ConsumerStatefulWidget {
  const CustomerRegistrationScreen({super.key});

  @override
  ConsumerState<CustomerRegistrationScreen> createState() =>
      CustomerRegistrationScreenState();
}

class CustomerRegistrationScreenState
    extends ConsumerState<CustomerRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    //  final userModelAsync = ref.watc(getMeProvider);
    final appRouter = ref.watch(appRouterProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cadastro de Clientes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userLoginServiceProvider).logout();
              appRouter.pushReplacement('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const AvatarWidget.withoutButton(),
                  const SizedBox(height: 24),
                  const Text(
                    'displayName', // displayName.toString() ,
                    style: TextStyle(
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
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
                      // await Navigator.of(context).pushNamed('/schedule', arguments: user,);
                      //  ref.invalidate(getTotalSchedulesTodayProvider(id));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('Atualizar Cadastro'),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      /*                    Navigator.of(context).pushNamed(
                            '/employee/schedule',
                            arguments: user,
                          ); */
                    },
                    child: const Text('Acessar Catalogo'),
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
