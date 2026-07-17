import 'package:flutter/material.dart';

class FeedbackCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const FeedbackCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  final TextEditingController searchController = TextEditingController();

  final List<String> feedbackList = [
    "Pending",
    "Solve",
    "Negative",
    "Reschedule Call/Visit",
    "Positive for Feasibility",
  ];

  String? selectedFeedback;

  @override
  Widget build(BuildContext context) {
    final filtered = feedbackList
        .where(
          (e) => e.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ),
        )
        .toList();

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 260,
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Select feedback...",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final selected = item == selectedFeedback;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedFeedback = item;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        color: selected ? Colors.teal : Colors.white,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black87,
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: selectedFeedback == null
                          ? null
                          : () {
                              widget.onSend(selectedFeedback!);
                            },
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onBack,
                      child: const Text("← Back"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}