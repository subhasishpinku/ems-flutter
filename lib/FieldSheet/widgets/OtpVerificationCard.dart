import 'package:flutter/material.dart';

class OtpVerificationCard extends StatefulWidget {
  final String mobile;
  final Function(String otp) onVerify;
  final VoidCallback onResend;
  final VoidCallback onBack;

  const OtpVerificationCard({
    super.key,
    required this.mobile,
    required this.onVerify,
    required this.onResend,
    required this.onBack,
  });

  @override
  State<OtpVerificationCard> createState() => _OtpVerificationCardState();
}

class _OtpVerificationCardState extends State<OtpVerificationCard> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "OTP sent to ${widget.mobile}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "Enter OTP",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (otpController.text.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter valid OTP"),
                            ),
                          );
                          return;
                        }

                        widget.onVerify(
                          otpController.text,
                        );
                      },
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onResend,
                      child: const Text("Resend OTP"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onBack,
                      child: const Text("← Back"),
                    ),
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