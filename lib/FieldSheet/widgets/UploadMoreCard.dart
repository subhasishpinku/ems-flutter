import 'package:flutter/material.dart';

// UploadMoreCard.dart
import 'package:flutter/material.dart';

class UploadMoreCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const UploadMoreCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<UploadMoreCard> createState() => _UploadMoreCardState();
}

class _UploadMoreCardState extends State<UploadMoreCard> {
  String? option;

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
              DropdownButtonFormField<String>(
                value: option,
                decoration: InputDecoration(
                  hintText: "Select...",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem<String>(
                    value: "Yes, add more",
                    child: Text("Yes, add more"),
                  ),
                  DropdownMenuItem<String>(
                    value: "No, continue",
                    child: Text("No, continue"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    option = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: option == null
                          ? null
                          : () {
                              widget.onSend(option!);
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