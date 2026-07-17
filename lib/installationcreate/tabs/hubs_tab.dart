import 'package:flutter/material.dart';

class HubsTab extends StatefulWidget {
  const HubsTab({super.key});

  @override
  State<HubsTab> createState() => _HubsTabState();
}

class _HubsTabState extends State<HubsTab> {
  final List<Map<String, dynamic>> hubs = [
    {
      "sl": 1,
      "linkType": "",
      "hub": "",
      "distance": "",
      "fiber": "",
      "remark": "",
    }
  ];

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value.isEmpty ? null : value,
      hint: const Text("--Select--"),
      underline: const SizedBox(),
      isExpanded: true,
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget buildTextField(String value, Function(String) onChanged) {
    return SizedBox(
      width: 120,
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade200),
                  columns: const [
                    DataColumn(label: Text("Sl No")),
                    DataColumn(label: Text("Link Type")),
                    DataColumn(label: Text("Hub")),
                    DataColumn(label: Text("Distance")),
                    DataColumn(label: Text("Fiber Required")),
                    DataColumn(label: Text("Remark")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: List.generate(
                    hubs.length,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${index + 1}")),

                          DataCell(
                            SizedBox(
                              width: 150,
                              child: buildDropdown(
                                value: hubs[index]["linkType"],
                                items: const [
                                  "Primary",
                                  "Secondary",
                                  "Backup",
                                ],
                                onChanged: (v) {
                                  setState(() {
                                    hubs[index]["linkType"] = v!;
                                  });
                                },
                              ),
                            ),
                          ),

                          DataCell(
                            SizedBox(
                              width: 180,
                              child: buildDropdown(
                                value: hubs[index]["hub"],
                                items: const [
                                  "Hub A",
                                  "Hub B",
                                  "Hub C",
                                ],
                                onChanged: (v) {
                                  setState(() {
                                    hubs[index]["hub"] = v!;
                                  });
                                },
                              ),
                            ),
                          ),

                          DataCell(
                            buildTextField(
                              hubs[index]["distance"],
                              (v) => hubs[index]["distance"] = v,
                            ),
                          ),

                          DataCell(
                            buildTextField(
                              hubs[index]["fiber"],
                              (v) => hubs[index]["fiber"] = v,
                            ),
                          ),

                          DataCell(
                            buildTextField(
                              hubs[index]["remark"],
                              (v) => hubs[index]["remark"] = v,
                            ),
                          ),

                          DataCell(
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                if (hubs.length > 1) {
                                  setState(() {
                                    hubs.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      hubs.add({
                        "sl": hubs.length + 1,
                        "linkType": "",
                        "hub": "",
                        "distance": "",
                        "fiber": "",
                        "remark": "",
                      });
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add Hub",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(0);
                    },
                    child: const Text(
                      "Previous",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(2);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}