import 'package:flutter/material.dart';

import '../../helpers/login_validator.dart';

import '../../routes/app_routes.dart';

import '../../styles/app_color.dart';
import '../../styles/app_fontstyle.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/home_indicator.dart';
import '../../widgets/button_divider.dart';
import '../../widgets/continue_button.dart';

// Halaman Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk input email
  final TextEditingController _emailController = TextEditingController();

  // Key untuk validasi form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Konten utama (SCROLL + SAFE)
          SafeArea(
            child: SingleChildScrollView(
              // Padding bawah WAJIB agar tidak ketutup HomeIndicator
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Center(child: WanderlyLogo()), // Logo (CENTER FIX)
                  const SizedBox(height: 32),

                  // Text navigasi ke Register
                  Text(
                    "Didn’t have account ?",
                    style: AppFonts.base(
                      engine: FontEngine.inter,
                      size: 16,
                      weight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke Register Screen
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      "Create one here!",
                      style: AppFonts.base(
                        engine: FontEngine.inter,
                        size: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form Email
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 327,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'username@gmail.com',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // Validasi email tidak kosong dan format valid
                        validator: (value) =>
                            LoginValidator.validateEmail(value ?? ''),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Button Continue
                  SizedBox(
                    width: 327,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Validasi form sebelum navigasi
                        if (_formKey.currentState!.validate()) {
                          // Navigasi ke Home jika valid
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
                          );
                        }
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Divider Or
                  const SizedBox(width: 327, child: ButtonDivider()),

                  const SizedBox(height: 16),

                  // Button Google
                  ContinueButton(
                    text: 'Continue with Google',
                    iconPath: 'assets/image/auth/google_logo.png',
                    onPressed: () {
                      // Hanya UI, belum ada logic login Google
                    },
                  ),

                  const SizedBox(height: 8),

                  // Button Apple
                  ContinueButton(
                    text: 'Continue with Apple',
                    iconPath: 'assets/image/auth/apple_logo.png',
                    onPressed: () {
                      // Hanya UI, belum ada logic login Apple
                    },
                  ),

                  const SizedBox(height: 16),

                  // Terms & Privacy
                  SizedBox(
                    width: 300,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppFonts.base(
                          engine: FontEngine.inter,
                          size: 12,
                          color: isDark
                              ? Colors.white
                              : colors.textSecondary,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'By clicking continue, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Home Indicator (FIXED di bawah)
          const Align(
            alignment: Alignment.bottomCenter,
            child: HomeIndicator(),
          ),
        ],
      ),
    );
  }
}
