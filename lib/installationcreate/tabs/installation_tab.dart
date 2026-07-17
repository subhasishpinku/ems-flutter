import 'package:flutter/material.dart';

class InstallationTab extends StatefulWidget {
  const InstallationTab({super.key});

  @override
  State<InstallationTab> createState() => _InstallationTabState();
}

class _InstallationTabState extends State<InstallationTab> {
  final TextEditingController dateController = TextEditingController();

  String? feasibility;
  String? installationVendor;
  String? carVendor;
  String? vehicleNo;
  String? fiberLaid;
  String? teamLeader;

  final List<String> dropdownItems = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  @override
  void initState() {
    super.initState();
    dateController.text =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  }

  Widget buildDropdown({
    required String title,
    required IconData icon,
    required Color color,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    hint: const Text("-- Select One --"),
                    isExpanded: true,
                    items: dropdownItems
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today),
            suffixIcon: const Icon(Icons.date_range),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2050),
              initialDate: DateTime.now(),
            );

            if (picked != null) {
              dateController.text =
                  "${picked.day}/${picked.month}/${picked.year}";
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Feasibility ID",
                      icon: Icons.assignment,
                      color: Colors.deepPurple,
                      value: feasibility,
                      onChanged: (v) {
                        setState(() {
                          feasibility = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Car Vendor",
                      icon: Icons.directions_car,
                      color: Colors.blue,
                      value: carVendor,
                      onChanged: (v) {
                        setState(() {
                          carVendor = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Vehicle No",
                      icon: Icons.local_shipping,
                      color: Colors.orange,
                      value: vehicleNo,
                      onChanged: (v) {
                        setState(() {
                          vehicleNo = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Installation Vendor",
                      icon: Icons.business,
                      color: Colors.blue,
                      value: installationVendor,
                      onChanged: (v) {
                        setState(() {
                          installationVendor = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Fiber Laid (KM)",
                      icon: Icons.route,
                      color: Colors.green,
                      value: fiberLaid,
                      onChanged: (v) {
                        setState(() {
                          fiberLaid = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDropdown(
                      title: "Team Leader",
                      icon: Icons.person,
                      color: Colors.purple,
                      value: teamLeader,
                      onChanged: (v) {
                        setState(() {
                          teamLeader = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 350,
                    child: buildDateField(),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(1);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "View LCO Details",
                      style: TextStyle(color: Colors.white),
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