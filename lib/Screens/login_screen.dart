import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:securechat/classes/routes.dart';
import 'package:securechat/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();
  var logger = Logger();
  List<String> data = [];
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restoreData();
  }

  Future<void> restoreData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? data = prefs.getStringList('data');
      if (data != null && data.length == 2) {
        emailController.text = data[0];
        passwordController.text = data[1];
        setState(() {});
      }
    } catch (e) {
      logger.d(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: userForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 200,
                    height: 200,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        'Remember Me',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Routes.forgetPassword(context: context);
                      },
                      child: const Text("Forget Password")),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () async {
                        LoginController.logInFunc(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                            isChecked: isChecked,
                            userForm: userForm);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text("Don`t have an account?"),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Routes.openSignUp(context: context);
                          },
                          child: const Text(
                            ' Signup Here',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
