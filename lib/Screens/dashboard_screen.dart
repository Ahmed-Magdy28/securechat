import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:securechat/classes/routes.dart';
import 'package:securechat/classes/shared_class.dart';
import 'package:securechat/controllers/dashboard_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData = {};

  var db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();

    SharedClass.getDataDB(
      db: db,
      user: user,
      setUserData: (fetchedData) {
        setState(() {
          userData = fetchedData;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
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
                      // add the profile name for the user
                      title: Text("${userData?["name"] ?? "Name Not Found"}"),
                      leading: const CircleAvatar(),
                      onTap: () {
                        Routes.profileRoute(
                            context: context, userData: userData);
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
                  Routes.settingRoute(context: context, userData: userData);
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
        ),
        appBar: AppBar(
          title: const Text('SecureChat'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('Welcome to SecureChat App'),
              const SizedBox(height: 20),
              const Text('You are logged in'),
              const SizedBox(height: 20),
              Text('Email: ${(user?.email ?? '').toString()}'),
            ],
          ),
        ));
  }
}
