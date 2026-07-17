import 'package:flutter/material.dart';

class DvrTitle extends StatelessWidget {
  final String text;

  const DvrTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff3B4A69),
        ),
      ),
    );
  }
}