import 'package:ems/LeaveApplication/addemployee_leave.dart';
import 'package:ems/LeaveApplication/widgets/date_field.dart';
import 'package:ems/LeaveApplication/widgets/dropdown_field.dart';
import 'package:ems/LeaveApplication/widgets/leavelist_page.dart';
import 'package:flutter/material.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

  String? employee;
  String? status;

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );

    if (date != null) {
      controller.text =
          "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Employee Leave",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff13294B),
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                DateField(
                  title: "From",
                  controller: fromDate,
                  onTap: () => pickDate(fromDate),
                ),

                DateField(
                  title: "To",
                  controller: toDate,
                  onTap: () => pickDate(toDate),
                ),

                DropdownField(
                  title: "Employee",
                  hint: "-- All employees --",
                  value: employee,
                  items: const ["Rahul", "Ayan", "Rohit", "Priya"],
                  onChanged: (v) {
                    setState(() {
                      employee = v;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 15,
              runSpacing: 15,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                DropdownField(
                  title: "Status",
                  hint: "-- All --",
                  value: status,
                  width: 220,
                  items: const ["Pending", "Approved", "Rejected"],
                  onChanged: (v) {
                    setState(() {
                      status = v;
                    });
                  },
                ),

                SizedBox(
                  width: 120,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3F73F6),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  width: 120,
                  height: 42,
                  child: OutlinedButton(
                    onPressed: () {
                      fromDate.clear();
                      toDate.clear();

                      setState(() {
                        employee = null;
                        status = null;
                      });
                    },
                    child: const Text("Clear"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEmployeeLeave(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Leave Application",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            LeaveListPage(),
          ],
        ),
      ),
    );
  }
}
