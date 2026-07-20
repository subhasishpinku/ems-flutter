import 'package:flutter/material.dart';

// UploadOptionCard.dart
import 'package:flutter/material.dart';

class UploadOptionCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const UploadOptionCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<UploadOptionCard> createState() => _UploadOptionCardState();
}

class _UploadOptionCardState extends State<UploadOptionCard> {
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
                    value: "Yes, add documents",
                    child: Text("Yes, add documents"),
                  ),
                  DropdownMenuItem<String>(
                    value: "No, skip",
                    child: Text("No, skip"),
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