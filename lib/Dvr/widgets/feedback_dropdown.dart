import 'package:flutter/material.dart';

class FeedbackDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const FeedbackDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      hint: const Text("-- Select one --"),
      items: const [
        DropdownMenuItem(
          value: "Excellent",
          child: Text("Excellent"),
        ),
        DropdownMenuItem(
          value: "Good",
          child: Text("Good"),
        ),
        DropdownMenuItem(
          value: "Average",
          child: Text("Average"),
        ),
        DropdownMenuItem(
          value: "Poor",
          child: Text("Poor"),
        ),
      ],
      onChanged: onChanged,
    );
  }
}