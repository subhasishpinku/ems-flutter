import 'package:ems/view/Home/model/dashboard_month.dart';
import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthYearCard extends StatelessWidget {
  const MonthYearCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

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
                    fontSize: 17,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: provider.months.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(width: 12),
                          Text("Loading months..."),
                        ],
                      ),
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButton<DashboardMonth>(
                        value: provider.selectedMonth,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),

                        items: provider.months.map((month) {
                          return DropdownMenuItem<DashboardMonth>(
                            value: month,
                            child: Text(
                              month.label,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),

                        onChanged: (DashboardMonth? month) {
                          if (month != null) {
                            provider.changeMonth(month);
                          }
                        },
                      ),
                    ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(
                      text: "🗓️ You selected ",
                    ),
                    TextSpan(
                      text:
                          provider.selectedMonth?.label ??
                          "No Month Selected",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "\nView attendance and visit reports for this month.",
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