import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitReportCard extends StatelessWidget {
  const VisitReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
            "Visit Report Summary",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "July 2026 employee wise summary",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 18),

          /// Row 1
          Row(
            children: [
              Expanded(
                child: ReportBox(
                  title: "TOTAL VISITS",
                  value: provider.visitSummary?.totalVisits.toString() ?? "0",
                  color: const Color(0xff16766F),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ReportBox(
                  title: "POSITIVE RESPONSE",
                  value:
                      provider.visitSummary?.positiveResponse.toString() ?? "0",
                  color: const Color(0xff6A2BD8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Row 2
          Row(
            children: [
              Expanded(
                child: ReportBox(
                  title: "AVG TIME SPEND",
                  value: provider.visitSummary?.avgTimeSpend ?? "00:00",
                  color: const Color(0xffC2185B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ReportBox(
                  title: "TOTAL WORKING HOUR",
                  value: provider.visitSummary?.totalWorkingHour ?? "00:00",
                  color: const Color(0xff1673A8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Row 3
          Row(
            children: [
              Expanded(
                child: ReportBox(
                  title: "TOTAL VISIT",
                  value: provider.visitSummary?.totalVisit ?? "00:00",
                  color: const Color(0xff2C59D8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ReportBox(
                  title: "IDLE TIME",
                  value: provider.visitSummary?.idleTime ?? "00:00",
                  color: const Color(0xff47556E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReportBox extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const ReportBox({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          const Text(
            "Tap for details",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
