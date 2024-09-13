import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:securechat/Screens/dashboard_screen.dart';
import 'package:securechat/classes/shared_class.dart';
import 'package:securechat/controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var userForm = GlobalKey<FormState>();
  var logger = Logger();
  bool isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: userForm,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!value.contains('@') &&
                            !value.contains('.com')) {
                          return 'Please enter true Email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: countryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Country is required';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: 'Country'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      )),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) async {
                          if (value != null && value) {
                            isChecked = value;
                            setState(() {});
                          } else {
                            setState(() {
                              isChecked = false;
                            });
                          }
                        },
                        activeColor: Colors.blue,
                      ),
                      const Text(
                        'Remember Me in login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (userForm.currentState!.validate()) {
                          if (await SignupController.createAccount(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                              country: countryController.text,
                              name: nameController.text)) {
                            if (isChecked) {
                              await SharedClass.saveData(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
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
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DashBoardScreen()),
                                              (route) => false);
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
      ),
    );
  }
}
