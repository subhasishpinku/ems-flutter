import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Attendance",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            "July 2026 monthly report",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: AttendanceBox(
                  title: "PRESENT",
                  count: provider.attendance?.present.toString() ?? "0",
                  color: const Color(0xff169A45),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AttendanceBox(
                  title: "ABSENT",
                  count: provider.attendance?.absent.toString() ?? "0",
                  color: const Color(0xffE53935),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: AttendanceBox(
                  title: "LATE IN",
                  count: provider.attendance?.lateIn.toString() ?? "0",
                  color: const Color(0xffF39C12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AttendanceBox(
                  title: "LATE OUT",
                  count: provider.attendance?.lateOut.toString() ?? "0",
                  color: const Color(0xff2D5BE3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AttendanceBox extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const AttendanceBox({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),

            const Text(
              "Tap for details",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
