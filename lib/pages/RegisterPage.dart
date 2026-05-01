import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fooddelivery/services/auth/AuthService.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;         // ── NEW
  bool _obscureConfirmPassword = true;  // ── NEW

  void register() async {
    final authService = AuthService();
    if (passwordController.text != confirmPasswordController.text) {
      _showError("Passwords don't match. Please try again.");
      return;
    }
    try {
      await authService.signUpWithEmailPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      _showError(_friendlyError(e.toString()));
    }
  }

  // ── NEW: reusable glassy snackbar ──
  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.75),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(message,
                          style: const TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _friendlyError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'An account with this email already exists.';
    } else if (error.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak. Use at least 6 characters.';
    }
    return 'Something went wrong. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final glassColor =
    isDark ? Colors.white.withOpacity(0.07) : Colors.white.withOpacity(0.45);
    final glassBorder =
    isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.6);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Reno_Logo.jpg', height: 120),
              const SizedBox(height: 20),
              Text(
                "Create an Account",
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),

              // ── NEW: glassy card ──
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: glassColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: glassBorder, width: 1.2),
                    ),
                    child: Column(
                      children: [
                        // Email
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password + eye
                        TextField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outline,
                                color: Theme.of(context).colorScheme.primary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () =>
                                  setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Confirm password + eye
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: Icon(Icons.enhanced_encryption_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () => setState(() =>
                              _obscureConfirmPassword = !_obscureConfirmPassword),
                            ),
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign up button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.background,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Log in here",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}