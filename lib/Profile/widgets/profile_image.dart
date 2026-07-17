import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage("assets/profile.jpg"),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload, size: 16),
              label: const Text("Upload"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {},
              child: const Text("Reset"),
            )
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          "Allowed JPG, PNG",
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}