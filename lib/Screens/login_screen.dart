import 'package:flutter/material.dart';
import 'package:securechat/Screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void openSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
            key: userForm,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
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
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 9 ||
                            !RegExp(r'[A-Z]').hasMatch(value) ||
                            !RegExp(r'[0-9]').hasMatch(value)) {
                          return ('The password must be at least 9 characters and \ncontain capital letters and numbers');
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
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (userForm.currentState!.validate()) {}
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: openSignUp,
                  child: const Text('Don`t have an account? Sign Up'),
                ),
              ],
            )),
      ),
    );
  }
}
