import 'package:flutter/material.dart';
import 'package:securechat/Screens/dashboard_screen.dart';
import 'package:securechat/Screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     openLogin();
  //   });

  //   // TODO: implement initState
  //   super.initState();
  // }

  void openDashboard() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DashBoardScreen()));
  }

  void openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Welcome to SecureChat App"),
            const SizedBox(
              height: 60,
            ),
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: openLogin,
                child: const Text("Get Started")),
          ],
        ),
      ),
    );
  }
}
