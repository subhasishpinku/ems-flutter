import 'package:flutter/material.dart';

class HubActionButtons extends StatelessWidget {
  const HubActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search),
          label: const Text("Search"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3F6EF6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),

        const SizedBox(width: 10),

        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.description),
          label: const Text("Export"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}