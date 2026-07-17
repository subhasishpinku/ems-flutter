import 'package:ems/view/ForgotPassword/Provider/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black45,

      body: Center(

        child: SingleChildScrollView(

          child: Container(

            width: 430,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black26,
                  offset: Offset(0, 12),
                )
              ],
            ),

            child: Column(

              children: [

                Container(

                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: const BoxDecoration(

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),

                    gradient: LinearGradient(

                      colors: [
                        Color(0xff3949AB),
                        Color(0xff0097A7),
                      ],
                    ),
                  ),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(

                        height: 48,
                        width: 48,

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: const Icon(
                          Icons.lock_open,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "Reset password",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Enter your registered email and we will send a secure reset link.",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                        ),
                      )
                    ],
                  ),
                ),

                Padding(

                  padding: const EdgeInsets.all(24),

                  child: Form(

                    key: formKey,

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "EMAIL ADDRESS",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5B6B96),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextFormField(

                          controller: emailController,

                          validator: (value) {

                            if (value!.isEmpty) {
                              return "Email required";
                            }

                            if (!value.contains("@")) {
                              return "Enter valid email";
                            }

                            return null;
                          },

                          decoration: InputDecoration(

                            hintText: "name@example.com",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xff3949AB),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Consumer<ForgotPasswordProvider>(
                          builder: (_, provider, __) {
                            return SizedBox(

                              width: double.infinity,
                              height: 48,

                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(

                                  backgroundColor:
                                      const Color(0xff3949AB),

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                ),

                                onPressed: provider.isLoading
                                    ? null
                                    : () async {

                                        if (formKey.currentState!
                                            .validate()) {

                                          await provider.sendResetLink(
                                              emailController.text);

                                          if (context.mounted) {

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Reset link sent successfully"),
                                              ),
                                            );
                                          }
                                        }
                                      },

                                child: provider.isLoading
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child:
                                            CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "Send reset link",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
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