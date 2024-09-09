import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
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
              const SizedBox(height: 20),
              Text('UID: ${(user?.uid ?? '').toString()}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: const Text('Logout'),
              )
            ],
          ),
        ));
  }
}
