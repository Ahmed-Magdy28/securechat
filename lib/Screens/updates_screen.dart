import 'package:flutter/material.dart';
import 'package:securechat/Widgets/my_footer.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Updates"),
      ),
      body: const Center(
        child: Text("UpdatesScreen"),
      ),
      bottomNavigationBar: const MyFooter(),
    );
  }
}
