import 'package:flutter/material.dart';

import '../../helpers/register_validator.dart';

import '../../routes/app_routes.dart';

import '../../styles/app_color.dart';
import '../../styles/app_fontstyle.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/button_divider.dart';
import '../../widgets/login_outline_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _hidePass = true;
  bool _hideConfirm = true;

  String _gender = 'Pria';
  String _countryCode = '+62';

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // LOGO (CENTER + FIXED GAP)
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32), // JARAK PASTI DARI KOTAK HITAM

            // KOTAK HITAM
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.72,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.black,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 24),

                          Text(
                            'Account register',
                            style: AppFonts.base(
                              engine: FontEngine.urbanist,
                              size: 24,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 24),

                          _label('Full Name *'),
                          _input(
                            _fullNameCtrl,
                            validator:
                                RegisterValidator.validateFullName,
                          ),

                          _label('Email *'),
                          _input(
                            _emailCtrl,
                            validator:
                                RegisterValidator.validateEmail,
                          ),

                          _label('Jenis Kelamin *'),
                          _genderDropdown(),

                          _label('No. Hp *'),
                          _phoneInput(),

                          _label('Kata Sandi *'),
                          _passwordField(
                            _passwordCtrl,
                            _hidePass,
                            () => setState(
                                () => _hidePass = !_hidePass),
                          ),

                          _label('Konfirmasi Kata Sandi *'),
                          _passwordField(
                            _confirmCtrl,
                            _hideConfirm,
                            () => setState(() =>
                                _hideConfirm = !_hideConfirm),
                            validator: (v) =>
                                RegisterValidator
                                    .validateConfirmPassword(
                              v,
                              _passwordCtrl.text,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.caption(context)
                                  .copyWith(color: Colors.white),
                            ),
                          ),

                          const SizedBox(height: 24),

                          _registerButton(),
                          const SizedBox(height: 16),
                          _loginButton(),

                          const SizedBox(height: 24),
                          const ButtonDivider(),
                          const SizedBox(height: 24),

                          LoginOutlineButton(
                            text: 'Login with Google',
                            iconPath:
                                'assets/image/auth/google_logo.png',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 12),
                          LoginOutlineButton(
                            text: 'Login with Apple',
                            iconPath:
                                'assets/image/auth/apple_logo.png',
                            onPressed: () {},
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== COMPONENT =====

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: text.replaceAll('*', ''),
            style:
                AppTextStyles.body(context).copyWith(color: Colors.white),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _genderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _gender,
        items: const [
          DropdownMenuItem(value: 'Pria', child: Text('Pria')),
          DropdownMenuItem(value: 'Wanita', child: Text('Wanita')),
        ],
        onChanged: (v) => setState(() => _gender = v!),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _phoneInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 121,
            height: 48,
            color: Colors.white,
            child: DropdownButtonFormField<String>(
              value: _countryCode,
              items: const [
                DropdownMenuItem(value: '+62', child: Text('🇮🇩 +62')),
                DropdownMenuItem(value: '+1', child: Text('🇺🇸 +1')),
              ],
              onChanged: (v) => setState(() => _countryCode = v!),
              decoration:
                  const InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: _phoneCtrl,
              validator: RegisterValidator.validatePhone,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField(
    TextEditingController controller,
    bool hidden,
    VoidCallback toggle, {
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator ?? RegisterValidator.validatePassword,
        obscureText: hidden,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(
                hidden ? Icons.visibility_off : Icons.visibility),
            onPressed: toggle,
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: 280,
      height: 34,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF808EE4),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.login,
              arguments: _emailCtrl.text,
            );
          }
        },
        child: const Text('Register'),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: 280,
      height: 34,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB5CAAE),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
        child: const Text(
          'Login',
          style: TextStyle(color: Color(0xFF808EE4)),
        ),
      ),
    );
  }
}
