import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:securechat/Screens/dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var userForm = GlobalKey<FormState>();
  var logger = Logger();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      return true;
    } catch (e) {
      logger.d(e);
      SnackBar messageSnakeBar = SnackBar(
          backgroundColor: Colors.red[400], content: Text(e.toString()));

      ScaffoldMessenger.of(context).showSnackBar(messageSnakeBar);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Form(
            key: userForm,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!value.contains('@')) {
                        return 'Please enter true Email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 9 ||
                            !RegExp(r'[A-Z]').hasMatch(value) ||
                            !RegExp(r'[0-9]').hasMatch(value)) {
                          return 'The Password must be at least 9 Characters and \ncontain Capital Letters and numbers';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(labelText: 'Password'),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (userForm.currentState!.validate()) {
                      if (await createAccount()) {
                        showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Account Created'),
                                content: const Text(
                                    'Your account has been created successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DashBoardScreen()));
                                    },
                                    child: const Text('OK'),
                                  )
                                ],
                              );
                            });
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color?>(Colors.blue),
                  ),
                  child: const Text('Create Account',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login',
                      style: TextStyle(color: Colors.black87)),
                ),
              ],
            )),
      ),
    );
  }
}
