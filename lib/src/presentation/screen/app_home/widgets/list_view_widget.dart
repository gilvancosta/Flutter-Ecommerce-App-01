import 'package:flutter/material.dart';

import 'list_tile_widget.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTileWidget(
            title: 'Provider Simple',
            subTitle: 'Un provider de sólo lectura',
            location: '/provider',
            icon: Icons.smart_button_outlined),
        ListTileWidget(
            title: 'Provider + Go_Router',
            subTitle: 'Un uso aplicado',
            location: '/provider-router',
            icon: Icons.credit_card),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ListTileWidget(
            title: 'Notifier Provider',
            subTitle: 'Un estado para almacenar un objeto',
            location: '/notifier-provider',
            icon: Icons.refresh_rounded),
        ListTileWidget(
            title: 'Notifier Provider + Provider',
            subTitle: 'TODO - Una mezcla entre providers',
            location: '/todo',
            icon: Icons.info_outline),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ListTileWidget(
            title: 'Future Provider',
            subTitle: 'Mantener el estado de un future y su retorno',
            location: '/future-provider',
            icon: Icons.check_box_outline_blank_rounded),
        ListTileWidget(
            title: 'Family Future Provider',
            subTitle: 'Providers con argumentos',
            location: '/future-family-provider',
            icon: Icons.car_rental_outlined),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ListTileWidget(
            title: 'Stream Provider',
            subTitle: 'Mantener el estado de un Stream y sus emosiones',
            location: '/stream-provider',
            icon: Icons.accessible_rounded),
      ],
    );
  }
}
