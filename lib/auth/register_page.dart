import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:miniproject3/data/api/bloc/auth/auth_bloc.dart';

import '../../resources/colors.dart';
import '../../resources/styles.dart';
import '../data/api/bloc/auth/auth_event.dart';
import '../data/api/bloc/auth/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            Fluttertoast.showToast(
              msg: 'Error: ${state.errorMessage}',
              toastLength: Toast.LENGTH_LONG,
            );
          } else if (state.userData != null) {
            Fluttertoast.showToast(
              msg: 'Registration successful!',
              toastLength: Toast.LENGTH_LONG,
            );
            context.go('/login');
          } else if (!state.isLoading) {
            Fluttertoast.showToast(
              msg: 'Registration failed. Please try again.',
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Create your",
                      textAlign: TextAlign.left,
                      style: Styles.appbarText.copyWith(fontSize: 24),
                    ),
                    Text(
                      "Account",
                      textAlign: TextAlign.left,
                      style: Styles.appbarText.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Enter your details to create an account",
                      style: Styles.subtitle,
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      "Email",
                      style: Styles.subtitle,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: Styles.subtitle,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      "Password",
                      style: Styles.subtitle,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: Styles.subtitle,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: Styles.subtitle.copyWith(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;

                                    if (email.isNotEmpty &&
                                        password.isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                            AuthRegister(
                                              email: email,
                                              password: password,
                                            ),
                                          );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please enter email and password!");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    minimumSize:
                                        const Size(double.infinity, 45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: Styles.title
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
