import 'package:flutter/material.dart';

class AddEmployeeLeave extends StatefulWidget {
  const AddEmployeeLeave({super.key});

  @override
  State<AddEmployeeLeave> createState() => _AddEmployeeLeaveState();
}

class _AddEmployeeLeaveState extends State<AddEmployeeLeave> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  String? leaveType;

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.year}";
    }
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff23395B),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Add Employee Leave"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width > 700 ? 700 : width * .95,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffD8E0EF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Employee Leave",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff23395B),
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.chevron_left),
                        label: const Text("View Employee Leave"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Remaining Leave 2",
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xff23395B),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      title("Type"),

                      DropdownButtonFormField<String>(
                        value: leaveType,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        hint: const Text("-- Select one --"),
                        items: const [
                          DropdownMenuItem(
                            value: "Casual Leave",
                            child: Text("Casual Leave"),
                          ),
                          DropdownMenuItem(
                            value: "Sick Leave",
                            child: Text("Sick Leave"),
                          ),
                          DropdownMenuItem(
                            value: "Emergency Leave",
                            child: Text("Emergency Leave"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            leaveType = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      title("From Date"),

                      TextField(
                        controller: fromDateController,
                        readOnly: true,
                        onTap: () => pickDate(fromDateController),
                        decoration: InputDecoration(
                          hintText: "mm/dd/yyyy",
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      title("To Date"),

                      TextField(
                        controller: toDateController,
                        readOnly: true,
                        onTap: () => pickDate(toDateController),
                        decoration: InputDecoration(
                          hintText: "mm/dd/yyyy",
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      title("Reason For Leave"),

                      TextField(
                        controller: reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter reason",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 100,
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
