import 'package:flutter/material.dart';

class LeadFilterDialog extends StatefulWidget {
  const LeadFilterDialog({super.key});

  @override
  State<LeadFilterDialog> createState() => _LeadFilterDialogState();
}

class _LeadFilterDialogState extends State<LeadFilterDialog> {
  String selectedRange = "Today";

  final List<String> dateRanges = [
    "Today",
    "Yesterday",
    "Last 7 Days",
    "Last 30 Days",
    "This Month",
    "Custom Range",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .95,
        height: MediaQuery.of(context).size.height * .90,
        child: Column(
          children: [
            // ========== HEADER ==========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 34,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // ========== BODY ==========
            Expanded(
              child: Row(
                children: [
                  // -------- LEFT MENU (220px) --------
                  Container(
                    width: 220,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 22, top: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date Range",
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xff404659),
                            ),
                          ),
                          SizedBox(height: 28),
                          Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xff404659),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // -------- RIGHT CONTENT --------
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date Range Buttons (Wrap with spacing)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: dateRanges.map((text) {
                              return SizedBox(
                                width: 140,
                                height: 52,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedRange = text;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: selectedRange == text
                                            ? const Color(0xff3F6DF6)
                                            : Colors.grey.shade300,
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Text(
                                      text,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 20),

                          // Date Picker (From - To)
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: const Icon(
                                        Icons.calendar_today_outlined,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "To",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: const Icon(
                                        Icons.calendar_today_outlined,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Additional filter options can be added here
                          // Example: Lead Status, Source, etc.
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ========== BOTTOM BUTTONS ==========
            Container(
              height: 85,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        // Reset logic
                        setState(() {
                          selectedRange = "Today";
                        });
                      },
                      child: const Text("Reset"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2F3B5C),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3F6DF6),
                        ),
                        onPressed: () {
                          // Apply logic
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text("Apply"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
