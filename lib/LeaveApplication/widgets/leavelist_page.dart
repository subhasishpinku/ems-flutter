import 'package:flutter/material.dart';

class LeaveListPage extends StatelessWidget {
  LeaveListPage({super.key});

  final List<Map<String, dynamic>> leaves = [
    {
      "employee": "Sumon Sardar",
      "date": "19-03-2026 - 21-03-2026",
      "reason": "Traveling with Family",
      "status": "Cancel",
      "applyDate": "2026-03-06 23:24",
    },
    {
      "employee": "Sumon Sardar",
      "date": "21-11-2025 - 22-11-2025",
      "reason": "Leave",
      "status": "Approved",
      "applyDate": "2025-11-21 16:13",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 700 ? _mobileView() : _desktopView();
      },
    );
  }

  Widget _desktopView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Sl")),
          DataColumn(label: Text("Employee")),
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Reason")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Apply Date")),
        ],
        rows: List.generate(leaves.length, (index) {
          final item = leaves[index];

          return DataRow(
            cells: [
              DataCell(Text("${index + 1}")),
              DataCell(Text(item["employee"])),
              DataCell(Text(item["date"])),
              DataCell(Text(item["reason"])),
              DataCell(Text(item["status"])),
              DataCell(Text(item["applyDate"])),
            ],
          );
        }),
      ),
    );
  }

  Widget _mobileView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: leaves.length,
      itemBuilder: (context, index) {
        final item = leaves[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["employee"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Text("Date : ${item["date"]}"),
                Text("Reason : ${item["reason"]}"),
                Text("Status : ${item["status"]}"),
                Text("Apply : ${item["applyDate"]}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
