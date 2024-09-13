import 'package:flutter/material.dart';
import 'package:securechat/Widgets/my_drawer.dart';
import 'package:securechat/Widgets/my_footer.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calls"),
      ),
      body: const Center(
        child: Text("CallsScreen"),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: const MyFooter(),
    );
  }
}
