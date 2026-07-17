import 'package:ems/view/LoginScreen/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xff3A4A8A),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
