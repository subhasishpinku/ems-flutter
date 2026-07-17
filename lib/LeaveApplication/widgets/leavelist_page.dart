import 'package:ems/LeaveApplication/providers/leave_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListPage extends StatelessWidget {
  const LeaveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
      builder: (context, provider, child) {
        if (provider.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.leaveList.isEmpty) {
          return const Center(child: Text("No Leave Found"));
        }

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
            rows: List.generate(provider.leaveList.length, (index) {
              final item = provider.leaveList[index];

              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(Text(item.employee)),
                  DataCell(Text("${item.fromDate} - ${item.toDate}")),
                  DataCell(Text(item.reason)),
                  DataCell(Text(item.status)),
                  DataCell(Text(item.applyDate)),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
