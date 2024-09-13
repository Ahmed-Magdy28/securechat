import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securechat/classes/routes.dart';
import 'package:securechat/controllers/dashboard_controller.dart';
import 'package:securechat/providers/user_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Center(
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue[200]),
                child: ListTile(
                  splashColor: Colors.yellow[200],
                  title: Text(userProvider.userName),
                  leading: CircleAvatar(
                    child: (userProvider.userImage != '')
                        ? Image.network(userProvider.userImage)
                        : Text(userProvider.userName[0]),
                  ),
                  onTap: () {
                    Routes.profileRoute(
                      context: context,
                    );
                  },
                ),
              ),
            ),
          ),
          ListTile(
            splashColor: Colors.grey[400],
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            onTap: () {
              Routes.settingRoute(
                context: context,
              );
            },
          ),
          ListTile(
            splashColor: Colors.red[400],
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              DashboardController.logoutFunc(context: context);
            },
          ),
        ],
      ),
    );
  }
}
