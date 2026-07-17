import 'package:ems/FieldSheet/FieldSheetCreate.dart';
import 'package:flutter/material.dart';

class FieldSheetScreen extends StatelessWidget {
  const FieldSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            _menuItem(
              color: Colors.red,
              icon: Icons.car_repair,
              title: "Field Sheet",
              onTap: () {
                // Navigator.push(...)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Fieldsheetcreate(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            _menuItem(
              color: const Color(0xff1E5AAE),
              icon: Icons.fact_check,
              title: "Confirm Field Sheet",
              onTap: () {
                // Navigator.push(...)
              },
            ),

            const SizedBox(height: 30),

            _menuItem(
              color: const Color(0xff2493D8),
              icon: Icons.description,
              title: "Field Sheet Report",
              onTap: () {
                // Navigator.push(...)
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required Color color,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
