import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/components/MyTextField.dart';
import 'package:fooddelivery/services/auth/AuthService.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController
  passwordController =
  TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final authService = AuthService();

    try {
      await authService
          .signInWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor:
              Theme.of(context)
                  .colorScheme
                  .inversePrimary
                  .withOpacity(0.92),
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    20),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color:
                    Theme.of(context)
                        .colorScheme
                        .primary,
                  ),
                  const SizedBox(
                      width: 8),
                  const Text(
                      "Login Failed"),
                ],
              ),
              content: Text(
                e.toString().replaceAll(
                    "Exception: ",
                    ""),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(
                          context),
                  child:
                  const Text("OK"),
                )
              ],
            ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
      Theme.of(context)
          .colorScheme
          .background,
      body: SafeArea(
        child: Center(
          child:
          SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius
                      .circular(
                      22),
                  child:
                  Image.asset(
                    'assets/images/Reno_Logo.jpg',
                    height: 140,
                  ),
                ),

                const SizedBox(
                    height: 25),

                Text(
                  "Welcome Back!",
                  style:
                  GoogleFonts
                      .lato(
                    fontSize: 22,
                    fontWeight:
                    FontWeight
                        .bold,
                    color: Theme.of(
                        context)
                        .colorScheme
                        .primary,
                  ),
                ),

                const SizedBox(
                    height: 25),

                MyTextField(
                  controller:
                  emailController,
                  hintText:
                  "Email",
                  obscureText:
                  false,
                  prefixIcon: Icons
                      .email_outlined,
                ),

                const SizedBox(
                    height: 15),

                Padding(
                  padding:
                  const EdgeInsets
                      .symmetric(
                      horizontal:
                      25),
                  child: TextField(
                    controller:
                    passwordController,
                    obscureText:
                    hidePassword,
                    decoration:
                    InputDecoration(
                      hintText:
                      "Password",
                      prefixIcon:
                      const Icon(
                        Icons
                            .lock_outline,
                      ),
                      suffixIcon:
                      IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons
                              .visibility_off
                              : Icons
                              .visibility,
                        ),
                        onPressed:
                            () {
                          setState(
                                  () {
                                hidePassword =
                                !hidePassword;
                              });
                        },
                      ),
                      border:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                isLoading
                    ? const CircularProgressIndicator()
                    : MyButton(
                  text:
                  "Sign In",
                  onTap:
                  login,
                ),

                const SizedBox(
                    height: 20),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  children: [
                    Text(
                      "Not a member?",
                      style:
                      TextStyle(
                        color: Theme.of(
                            context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    const SizedBox(
                        width: 5),
                    GestureDetector(
                      onTap:
                      widget
                          .onTap,
                      child: Text(
                        "Register Now",
                        style:
                        TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Theme.of(
                              context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}