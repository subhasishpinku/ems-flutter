import 'package:flutter/material.dart';

class MobileOtpCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const MobileOtpCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<MobileOtpCard> createState() => _MobileOtpCardState();
}

class _MobileOtpCardState extends State<MobileOtpCard> {
  final TextEditingController mobileController = TextEditingController();

  @override
  void dispose() {
    mobileController.dispose();
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
          width: 260,
          child: Column(
            children: [
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "Enter mobile number...",
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        final mobile = mobileController.text.trim();

                        if (mobile.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter valid 10 digit mobile number"),
                            ),
                          );
                          return;
                        }

                        widget.onSend(mobile);
                      },
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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