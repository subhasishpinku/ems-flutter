import 'package:flutter/material.dart';

class MaterialsTab extends StatefulWidget {
  const MaterialsTab({super.key});

  @override
  State<MaterialsTab> createState() => _MaterialsTabState();
}

class _MaterialsTabState extends State<MaterialsTab> {
  String? selectedMaterial;

  final TextEditingController qtyController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  final List<String> materialList = [
    "Fiber Cable",
    "Router",
    "ONU",
    "Patch Cord",
    "Connector",
  ];

  List<Map<String, dynamic>> materials = [];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Material Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [

                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      value: selectedMaterial,
                      decoration: const InputDecoration(
                        labelText: "Material Name",
                        border: OutlineInputBorder(),
                      ),
                      items: materialList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedMaterial = v;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: qtyController,
                      decoration: const InputDecoration(
                        labelText: "Used Qty",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: serialController,
                      decoration: const InputDecoration(
                        labelText: "Serial Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {

                        if (selectedMaterial == null) return;

                        setState(() {

                          materials.add({
                            "material": selectedMaterial,
                            "qty": qtyController.text,
                            "serial": serialController.text,
                          });

                          qtyController.clear();
                          serialController.clear();
                          selectedMaterial = null;
                        });

                      },
                      icon: const Icon(Icons.add,color: Colors.white),
                      label: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )

                ],
              ),

              const SizedBox(height: 30),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    Colors.grey.shade200,
                  ),
                  columns: const [

                    DataColumn(label: Text("Sl No")),
                    DataColumn(label: Text("Material")),
                    DataColumn(label: Text("Qty")),
                    DataColumn(label: Text("Serial No")),
                    DataColumn(label: Text("Action")),

                  ],
                  rows: List.generate(
                    materials.length,
                    (index) {
                      return DataRow(
                        cells: [

                          DataCell(Text("${index + 1}")),

                          DataCell(
                            Text(materials[index]["material"]),
                          ),

                          DataCell(
                            Text(materials[index]["qty"]),
                          ),

                          DataCell(
                            Text(materials[index]["serial"]),
                          ),

                          DataCell(
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {

                                setState(() {

                                  materials.removeAt(index);

                                });

                              },
                            ),
                          ),

                        ],
                      );
                    },
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

                      DefaultTabController.of(context).animateTo(1);

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

                      DefaultTabController.of(context).animateTo(3);

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