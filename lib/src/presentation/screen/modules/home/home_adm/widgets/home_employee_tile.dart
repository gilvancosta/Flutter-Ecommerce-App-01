import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/ui/barbershop_icons.dart';
import '../../../../../../domain/models/user_model.dart';

class HomeEmployeeTile extends StatelessWidget {
  const HomeEmployeeTile({
    super.key,
    required this.employee,
  });

  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ColorsConstants.grey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: switch (employee.photoURL) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ImageConstants.avatar),
                } as ImageProvider<Object>,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.displayName ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/schedule',
                          arguments: employee,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(double.infinity, 56),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/employee/schedule',
                          arguments: employee,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text('VER AGENDA'),
                    ),
                    const Icon(
                      BarbershopIcons.penEdit,
                      color: ColorsConstants.brow,
                      size: 16,
                    ),
                    const Icon(
                      BarbershopIcons.trash,
                      color: ColorsConstants.red,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
