import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 45,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        icon: const Icon(Icons.save, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}