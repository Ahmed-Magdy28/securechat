import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Screens/splash_screen.dart';
import 'package:securechat/firebase_options.dart';
import 'package:securechat/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const SecureChatApp()));
}

class SecureChatApp extends StatefulWidget {
  const SecureChatApp({super.key});

  @override
  State<SecureChatApp> createState() => _SecureChatAppState();
}

class _SecureChatAppState extends State<SecureChatApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}
