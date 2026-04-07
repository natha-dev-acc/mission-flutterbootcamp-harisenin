import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/validators.dart';

import '../../../routes/app_routes.dart';

import '../../../core/styles/app_color.dart';
import '../../../core/styles/app_fontstyle.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/home_indicator.dart';
// import '../../widgets/continue_button.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Center(child: WanderlyLogo()),
                  const SizedBox(height: 32),
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
                        validator: (value) =>
                            Validators.validateEmail(value ?? ''),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                // SIMPAN STATE DI SINI (Sebelum await)
                                // Ini untuk menghindari error 'async gaps'
                                final navigator = Navigator.of(context);
                                final messenger = ScaffoldMessenger.of(context);

                                final success = await ref
                                    .read(authProvider.notifier)
                                    .login(
                                      email: _emailController.text.trim(),
                                      password: '123456',
                                    );

                                if (success) {
                                  // Gunakan variabel navigator yang sudah disimpan
                                  navigator.pushReplacementNamed(
                                    AppRoutes.home,
                                  );
                                } else {
                                  final error = ref.read(authProvider).error ??
                                      'Login gagal';
                                  
                                  // Gunakan variabel messenger yang sudah disimpan
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
                              'Continue',
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
}
