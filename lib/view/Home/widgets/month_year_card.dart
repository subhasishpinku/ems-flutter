import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearCard extends StatefulWidget {
  const MonthYearCard({super.key});

  @override
  State<MonthYearCard> createState() => _MonthYearCardState();
}

class _MonthYearCardState extends State<MonthYearCard> {
  DateTime selectedDate = DateTime.now();

  Future<void> _pickMonthYear() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xff5C7CFA),
              Color(0xff7B4DBA),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Select Month & Year",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            InkWell(
              onTap: _pickMonthYear,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat("MMMM yyyy").format(selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: [
                    const TextSpan(text: "🗓️ You selected "),
                    TextSpan(
                      text: DateFormat("MMMM yyyy").format(selectedDate),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: " - View reports and data for this period.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}