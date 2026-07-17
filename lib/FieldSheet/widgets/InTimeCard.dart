import 'package:flutter/material.dart';

class InTimeCard extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback onBack;

  const InTimeCard({
    super.key,
    required this.onSend,
    required this.onBack,
  });

  @override
  State<InTimeCard> createState() => _InTimeCardState();
}

class _InTimeCardState extends State<InTimeCard> {
  TimeOfDay? selectedTime;

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
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
          width: 250,
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                onTap: pickTime,
                decoration: InputDecoration(
                  hintText: "--:-- --",
                  suffixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: TextEditingController(
                  text: selectedTime == null
                      ? ""
                      : selectedTime!.format(context),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: selectedTime == null
                          ? null
                          : () {
                              widget.onSend(
                                selectedTime!.format(context),
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