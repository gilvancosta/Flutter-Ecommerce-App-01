import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String location;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.location,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Provider Simple',
      subTitle: 'Un provider de sólo lectura',
      location: '/provider',
      icon: Icons.smart_button_outlined),
  MenuItem(
      title: 'Provider + Go_Router',
      subTitle: 'Un uso aplicado',
      location: '/provider-router',
      icon: Icons.credit_card),
  MenuItem(
      title: 'State Provider',
      subTitle: 'Un estado para almacenar un objeto',
      location: '/state-provider',
      icon: Icons.refresh_rounded),
  MenuItem(
      title: 'State Provider + Provider',
      subTitle: 'TODO - Una mezcla entre providers',
      location: '/todo',
      icon: Icons.info_outline),
  MenuItem(
      title: 'Future Provider',
      subTitle: 'Mantener el estado de un future y su retorno',
      location: '/future-provider',
      icon: Icons.check_box_outline_blank_rounded),
  MenuItem(
      title: 'Family Future Provider',
      subTitle: 'Providers con argumentos',
      location: '/future-family-provider',
      icon: Icons.car_rental_outlined),
  MenuItem(
      title: 'Stream Provider',
      subTitle: 'Mantener el estado de un Stream y sus emosiones',
      location: '/stream-provider',
      icon: Icons.accessible_rounded),
];
