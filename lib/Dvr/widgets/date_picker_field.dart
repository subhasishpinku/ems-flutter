import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}