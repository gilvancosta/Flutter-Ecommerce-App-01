import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../../core/widgets/avatar_widget.dart';


import '../widgets/home_header.dart';


class HomeCustomerView extends ConsumerWidget {
  const HomeCustomerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeHeader(
                                  name: 'Cliente',
              mensagem: 'Atualize seu Cadastro',
              hideFilter: false,  
          )),
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
                    child: const Text('AGENDAR CLIENTE'),
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
