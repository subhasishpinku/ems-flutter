// GpsRetryCard.dart
import 'package:flutter/material.dart';

class GpsRetryCard extends StatefulWidget {
  final Function(String) onSelect;
  final VoidCallback onBack;

  const GpsRetryCard({super.key, required this.onSelect, required this.onBack});

  @override
  State<GpsRetryCard> createState() => _GpsRetryCardState();
}

class _GpsRetryCardState extends State<GpsRetryCard> {
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
          width: 280,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: option,
                decoration: InputDecoration(
                  hintText: "Select...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem<String>(
                    value: "Retry Submit",
                    child: Text("Retry Submit (GPS enabled)"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Go Back",
                    child: Text("Go Back"),
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
                      onPressed: option == null
                          ? null
                          : () {
                              widget.onSelect(option!);
                            },
                      child: const Text("Continue"),
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
