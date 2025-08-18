import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_action_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Sign in to continue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF575959),
                ),
              ),
              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: _labeledField("First Name *", firstNameController),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _labeledField("Last Name", lastNameController),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _labeledField("Phone Number *", phoneController),
              const SizedBox(height: 16),
              _labeledField("Email Address *", emailController),
              const SizedBox(height: 16),
              _passwordField("Password *", passwordController),
              const SizedBox(height: 32),

              CustomActionButton(
                text: "Sign up",
                backgroundColor: const Color(0xFF1E535B),
                textColor: Colors.white,
                height: 50,
                onPressed: () {
                  //context.read<AuthBloc>().add(
                    Navigator.pushNamed(context, AppRoutes.dashboard);
                    SignUpUser(
                      firstNameController.text,
                      lastNameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                  );
                },
              ),

              const SizedBox(height: 24),

              Row(
                children: const [
                  Expanded(child: Divider(color: Color(0xFF575959))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Or",
                      style: TextStyle(color: Color(0xFF575959)),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFF575959))),
                ],
              ),

              const SizedBox(height: 26),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon("assets/images/Apple.png"),
                  const SizedBox(width: 20),
                  _buildSocialIcon("assets/images/Facebook.png"),
                  const SizedBox(width: 20),
                  _buildSocialIcon("assets/images/Google.png"),
                ],
              ),

              const SizedBox(height: 170),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16, color: Color(0xFF575959)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signIn),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1E535B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labeledField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF575959),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          cursorColor: const Color(0xFF575959),
          decoration: InputDecoration(
            hintText: "Enter $label",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF575959),
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF575959)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF575959),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: _obscurePassword,
          cursorColor: const Color(0xFF575959),
          decoration: InputDecoration(
            hintText: "Enter Password",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF575959),
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF575959)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFB8B8B8),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Image.asset(assetPath, width: 30, height: 30);
  }
}
