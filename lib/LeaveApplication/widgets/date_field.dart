import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onTap;

  const DateField({
    super.key,
    required this.title,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff3A4A67),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 42,
            child: TextField(
              controller: controller,
              readOnly: true,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: "mm/dd/yyyy",
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}