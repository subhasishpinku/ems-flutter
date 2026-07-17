import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String title;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double width;

  const DropdownField({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              hint: Text(
                hint,
                style: const TextStyle(fontSize: 13),
              ),
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}