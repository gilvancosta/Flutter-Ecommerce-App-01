import 'package:flutter/material.dart';

class DrawerV1Widget extends StatelessWidget {
  const DrawerV1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      //  child: ListView(
     //  padding: EdgeInsets.zero,
      children: <Widget>[
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
        // -- widget_page --

        ListTile(
            leading: const Icon(Icons.calculate_rounded),
            title: const Text('Page 1'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/page1');
              // Navigator.pop(context);
            }),
        ListTile(
            leading: const Icon(Icons.calculate_rounded),
            title: const Text('Page 2'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/page2');
              // Navigator.pop(context);
            }),

        // -- images_page --
      ],
      //   ),
    );
  }
}
