import 'package:ems/AddDailyVisit/AddDailyVisit.dart';
import 'package:ems/Dvr/provider/dvr_provider.dart';
import 'package:ems/Dvr/widgets/action_buttons.dart';
import 'package:ems/Dvr/widgets/date_picker_field.dart';
import 'package:ems/Dvr/widgets/dvr_title.dart';
import 'package:ems/Dvr/widgets/feedback_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DvrScreen extends StatefulWidget {
  const DvrScreen({super.key});

  @override
  State<DvrScreen> createState() => _DvrScreenState();
}

class _DvrScreenState extends State<DvrScreen> {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  String? feedback;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    final date =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    fromDateController.text = date;
    toDateController.text = date;

    Future.microtask(() {
      context.read<DvrProvider>().loadDvr(
        fromDate: date,
        toDate: date,
        feedback: "",
      );
    });
  }

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      controller.text =
          "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: SizedBox(
            width: width > 700 ? 700 : double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daily Visit Report",
                  style: TextStyle(
                    color: Color(0xff356BFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 120,
                  height: 2,
                  color: const Color(0xff356BFF),
                ),
                const SizedBox(height: 25),
                const DvrTitle(text: "Date"),
                DatePickerField(
                  controller: fromDateController,
                  onTap: () => pickDate(fromDateController),
                ),
                const SizedBox(height: 18),
                const DvrTitle(text: "To Date"),
                DatePickerField(
                  controller: toDateController,
                  onTap: () => pickDate(toDateController),
                ),
                const SizedBox(height: 18),
                const DvrTitle(text: "Feedback"),
                FeedbackDropdown(
                  value: feedback,
                  onChanged: (value) {
                    setState(() {
                      feedback = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ActionButtons(
                  onSearch: () {
                    context.read<DvrProvider>().loadDvr(
                      fromDate: fromDateController.text,
                      toDate: toDateController.text,
                      feedback: feedback ?? "",
                    );
                  },
                  onAdd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDailyVisit(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                buildDataTable(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataTable(BuildContext context) {
    final provider = context.watch<DvrProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final reports = provider.dvrList;

    if (reports.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("No DVR Found"),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: Colors.grey.shade300),
          headingRowHeight: 48,
          dataRowMinHeight: 55,
          dataRowMaxHeight: 55,
          headingRowColor: MaterialStateProperty.all(const Color(0xff0A2C86)),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          columns: const [
            DataColumn(label: Text("SL")),
            DataColumn(label: Text("NETWORK NAME")),
            DataColumn(label: Text("ENTRY DATE")),
            DataColumn(label: Text("NEAREST HUB")),
            DataColumn(label: Text("PROBLEM")),
            DataColumn(label: Text("FEEDBACK")),
            DataColumn(label: Text("IN TIME")),
            DataColumn(label: Text("OUT TIME")),
            DataColumn(label: Text("REMARKS")),
            DataColumn(label: Text("CREATED AT")),
            DataColumn(label: Text("ACTION")),
          ],
          rows: List.generate(reports.length, (index) {
            final item = reports[index];

            return DataRow(
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text(item["network_name"]?.toString() ?? "")),
                DataCell(Text(item["entry_date"]?.toString() ?? "")),
                DataCell(Text(item["nearest_hub"]?.toString() ?? "")),
                DataCell(Text(item["problem"]?.toString() ?? "")),
                DataCell(Text(item["feedback"]?.toString() ?? "")),
                DataCell(Text(item["in_time"]?.toString() ?? "")),
                DataCell(Text(item["out_time"]?.toString() ?? "")),
                DataCell(Text(item["remarks"]?.toString() ?? "")),
                DataCell(Text(item["created_at"]?.toString() ?? "")),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddDailyVisit(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
