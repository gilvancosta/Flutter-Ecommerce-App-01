import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import 'widgets/menu_items.dart';

class NavigationDrawerWidget extends ConsumerStatefulWidget {
  //final GlobalKey<ScaffoldState> scaffoldKey;

  const NavigationDrawerWidget({super.key});

  @override
  NavigationDrawerWidgetState createState() => NavigationDrawerWidgetState();
}

class NavigationDrawerWidgetState
    extends ConsumerState<NavigationDrawerWidget> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final appRouter = ref.watch(appRouterProvider);
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        appRouter.push(menuItem.location);
        // context.push(menuItem.link);
        // widget.scaffoldKey.currentState?.closeDrawer();
        Navigator.pop(context);
      },
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text("GitHub",
              style: TextStyle(fontSize: 20, color: Colors.black)),
          accountEmail: const Text("useremail@gmail.com",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              )),
          currentAccountPicture: CircleAvatar(
            minRadius: 40,
            child: Image.network(
              'https://pbs.twimg.com/profile_images/1723817670519234560/UnUMw34f_400x400.jpg',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Main'),
        ),
        ...appMenuItems.sublist(0, 2).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ...appMenuItems.sublist(2, 4).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ...appMenuItems.sublist(4, 6).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Divider(),
        ),
        ...appMenuItems.sublist(6).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 1, 1, 5),
          child: Text('More options'),
        ),
      ],
    );
  }
}
