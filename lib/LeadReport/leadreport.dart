import 'package:ems/LeadReport/widgets/lead_filter_dialog.dart';
import 'package:flutter/material.dart';

class LeadReport extends StatefulWidget {
  const LeadReport({super.key});

  @override
  State<LeadReport> createState() => _LeadReportState();
}

class _LeadReportState extends State<LeadReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(title: const Text("Lead Report"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Filter Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                side: const BorderSide(color: Color(0xff2F3B5C)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LeadFilterDialog(),
                );
              },
              icon: const Icon(Icons.filter_alt, color: Color(0xff2F3B5C)),
              label: const Text(
                "Filter",
                style: TextStyle(
                  color: Color(0xff2F3B5C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Dummy Content
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text("${index + 1}"),
                      ),
                      title: Text("Lead ${index + 1}"),
                      subtitle: const Text("Lead Details"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
