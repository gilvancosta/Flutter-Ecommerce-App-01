// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/constants.dart';

import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/ui/barbershop_icons.dart';

class HeaderScreenWidget extends ConsumerWidget {
  final String name;
  final String mensagem;
  final bool hideFilter;

  const HeaderScreenWidget({
    super.key,
    required this.name,
    required this.mensagem,
    required this.hideFilter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       final appRoutes = ref.watch(appRoutesProvider);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.5,
          image: AssetImage(
            ImageConstants.backgroundPage,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.maybeViewPaddingOf(context)?.top),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Atacadão Eletrônicos',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Sair',
                style: TextStyle(
                  color: ColorsConstants.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  //ref.read(homeADMVMProvider.notifier).logout();

                  appRoutes.pop();
                },
                icon: const Icon(
                  BarbershopIcons.exit,
                  color: ColorsConstants.grey,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
           Text(
            mensagem,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
