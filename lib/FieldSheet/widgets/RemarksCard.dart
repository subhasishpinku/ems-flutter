import 'package:flutter/material.dart';

class RemarksCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const RemarksCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<RemarksCard> createState() => _RemarksCardState();
}

class _RemarksCardState extends State<RemarksCard> {
  final TextEditingController remarksController = TextEditingController();

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: remarksController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter remarks...",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        widget.onSend(
                          remarksController.text.trim(),
                        );
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