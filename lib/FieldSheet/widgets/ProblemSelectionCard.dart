import 'package:flutter/material.dart';

class ProblemSelectionCard extends StatefulWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const ProblemSelectionCard({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<ProblemSelectionCard> createState() => _ProblemSelectionCardState();
}

class _ProblemSelectionCardState extends State<ProblemSelectionCard> {
  final TextEditingController search = TextEditingController();

  final List<String> problems = [
    "Existing Corporate Visit",
    "Existing LCO Visit",
    "Network Related",
    "New Corporate Visit",
    "New LCO Visit",
  ];

  String? selectedProblem;

  @override
  Widget build(BuildContext context) {
    final filtered = problems
        .where((e) => e.toLowerCase().contains(search.text.toLowerCase()))
        .toList();

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Search problem...",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final selected = selectedProblem == item;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedProblem = item;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        color: selected ? Colors.green : Colors.white,
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
              if (selectedProblem != null) ...[
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selected:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Chip(
                        backgroundColor: Colors.green,
                        label: Text(
                          selectedProblem!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                        onDeleted: () {
                          setState(() {
                            selectedProblem = null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onBack,
                      child: const Text("← Back"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: selectedProblem == null ? null : widget.onContinue,
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
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