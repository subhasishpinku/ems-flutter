import 'package:ems/view/ForgotPassword/forgotpassword.dart';
import 'package:ems/view/LoginScreen/providers/auth_provider.dart';
import 'package:ems/view/LoginScreen/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FC),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),

            child: Column(
              children: [
                Image.asset("assets/logo.png", height: 55),

                const SizedBox(height: 35),

                CustomTextField(
                  label: "EMAIL ADDRESS",
                  prefixIcon: Icons.person,
                  controller: emailController,
                ),

                const SizedBox(height: 20),

                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return CustomTextField(
                      label: "PASSWORD",
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                      obscureText: provider.obscurePassword,
                      suffix: IconButton(
                        onPressed: provider.togglePassword,
                        icon: Icon(
                          provider.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Checkbox(
                      value: provider.rememberMe,
                      activeColor: const Color(0xff3F51B5),
                      onChanged: (value) {
                        provider.toggleRemember(value!);
                      },
                    ),

                    const Text(
                      "Remember me",
                      style: TextStyle(color: Color(0xff4F5D8A)),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Color(0xff3247B8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),

                    onPressed: provider.isLoading
                        ? null
                        : () {
                            provider.login(
                              context,
                              emailController.text.trim(),
                              passwordController.text,
                            );
                          },

                    child: provider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
