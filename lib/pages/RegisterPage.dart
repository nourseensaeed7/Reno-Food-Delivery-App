import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/components/MyTextField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fooddelivery/services/auth/AuthService.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {
  final TextEditingController
  emailController =
  TextEditingController();

  final TextEditingController
  passwordController =
  TextEditingController();

  final TextEditingController
  confirmPasswordController =
  TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void register() async {
    final authService = AuthService();

    if (passwordController.text ==
        confirmPasswordController.text) {
      try {
        await authService
            .signUpWithEmailPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  e.toString(),
                ),
              ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
        const AlertDialog(
          title: Text(
              "Password don't match!"),
        ),
      );
    }
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
              mainAxisAlignment:
              MainAxisAlignment
                  .center,
              children: [
                Image.asset(
                  'assets/images/Reno_Logo.jpg',
                  height: 150,
                ),

                const SizedBox(
                    height: 25),

                Text(
                  "Let's Create an Account for you",
                  style:
                  GoogleFonts
                      .lato(
                    fontSize: 20,
                    color: Theme.of(
                        context)
                        .colorScheme
                        .primary,
                    fontWeight:
                    FontWeight
                        .w600,
                  ),
                ),

                const SizedBox(
                    height: 25),

                /// EMAIL
                MyTextField(
                  prefixIcon: Icons
                      .email_outlined,
                  controller:
                  emailController,
                  hintText:
                  "Email",
                  obscureText:
                  false,
                ),

                const SizedBox(
                    height: 15),

                /// PASSWORD WITH EYE
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
                    height: 15),

                /// CONFIRM PASSWORD WITH EYE
                Padding(
                  padding:
                  const EdgeInsets
                      .symmetric(
                      horizontal:
                      25),
                  child: TextField(
                    controller:
                    confirmPasswordController,
                    obscureText:
                    hideConfirmPassword,
                    decoration:
                    InputDecoration(
                      hintText:
                      "Confirm Password",
                      prefixIcon:
                      const Icon(
                        Icons
                            .enhanced_encryption_outlined,
                      ),
                      suffixIcon:
                      IconButton(
                        icon: Icon(
                          hideConfirmPassword
                              ? Icons
                              .visibility_off
                              : Icons
                              .visibility,
                        ),
                        onPressed:
                            () {
                          setState(
                                  () {
                                hideConfirmPassword =
                                !hideConfirmPassword;
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
                    height: 15),

                MyButton(
                  text: 'Sign up',
                  onTap: register,
                ),

                const SizedBox(
                    height: 15),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  children: [
                    Text(
                      "Already have an account?",
                      style:
                      TextStyle(
                        color: Theme.of(
                            context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    const SizedBox(
                        width: 4),
                    GestureDetector(
                      onTap:
                      widget
                          .onTap,
                      child: Text(
                        "Log in here",
                        style:
                        TextStyle(
                          color: Theme.of(
                              context)
                              .colorScheme
                              .primary,
                          fontWeight:
                          FontWeight.bold,
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