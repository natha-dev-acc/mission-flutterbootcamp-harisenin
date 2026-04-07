import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/validators.dart';
// import '../../../routes/app_routes.dart';

import '../../../core/styles/app_color.dart';
import '../../../core/styles/app_fontstyle.dart';

import '../../providers/auth_provider.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/home_indicator.dart';

// Halaman Register
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Center(child: WanderlyLogo()),
                  const SizedBox(height: 32),

                  // ===== NAVIGASI KE LOGIN =====
                  Text(
                    "Already have an account ?",
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back to login!",
                      style: AppFonts.base(
                        engine: FontEngine.inter,
                        size: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== FORM =====
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // FULL NAME
                        SizedBox(
                          width: 327,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: _inputDecoration('Full Name'),
                            validator: (value) =>
                                Validators.validateFullName(value ?? ''),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // EMAIL
                        SizedBox(
                          width: 327,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: _inputDecoration('Email'),
                            validator: (value) =>
                                Validators.validateEmail(value ?? ''),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // PASSWORD
                        SizedBox(
                          width: 327,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: _inputDecoration('Password'),
                            validator: (value) =>
                                Validators.validatePassword(value ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ===== BUTTON REGISTER =====
                  SizedBox(
                    width: 327,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                // Simpan state sebelum async gap
                                final navigator = Navigator.of(context);
                                final messenger = ScaffoldMessenger.of(context);

                                final success = await ref
                                    .read(authProvider.notifier)
                                    .register(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      fullName: _nameController.text.trim(),
                                    );

                                if (success) {
                                  // Notifikasi sukses menggunakan messenger tersimpan
                                  messenger.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Register Berhasil! Silakan login dengan email Anda!!'),
                                    ),
                                  );

                                  // Kembali ke Login menggunakan navigator tersimpan
                                  navigator.pop();
                                } else {
                                  final error = ref.read(authProvider).error ??
                                      'Gagal register';

                                  messenger.showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                }
                              }
                            },
                      child: authState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: HomeIndicator(),
          ),
        ],
      ),
    );
  }

  // Helper UI biar rapi
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
