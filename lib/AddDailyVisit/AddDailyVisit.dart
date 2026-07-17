import 'package:flutter/material.dart';

class AddDailyVisit extends StatefulWidget {
  const AddDailyVisit({super.key});

  @override
  State<AddDailyVisit> createState() => _AddDailyVisitState();
}

class _AddDailyVisitState extends State<AddDailyVisit> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController inTimeController = TextEditingController();
  final TextEditingController outTimeController = TextEditingController();

  String? visitType;
  String? lead;
  String? nearestHub;
  String? problemType;
  String? feedback;

  // Document list
  List<DocumentRow> documentRows = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateController.text =
        "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year}";

    documentRows.add(DocumentRow());
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      dateController.text =
          "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  Future<void> pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.hour >= 12 ? 'PM' : 'AM';
      final hour12 = picked.hour > 12 ? picked.hour - 12 : picked.hour;
      controller.text = "$hour12:$minute $period";
    }
  }

  void addDocumentRow() {
    setState(() {
      documentRows.add(DocumentRow());
    });
  }

  void removeDocumentRow(int index) {
    setState(() {
      documentRows.removeAt(index);
    });
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff304466),
        ),
      ),
    );
  }

  Widget gap() => const SizedBox(height: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Add Daily Visit"),
        backgroundColor: const Color(0xff151A63),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// DATE
                title("Date"),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: pickDate,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// VISIT TYPE
                title("Visit Type"),
                DropdownButtonFormField<String>(
                  value: visitType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  hint: const Text("-- Select one --"),
                  items: const [
                    DropdownMenuItem(
                      value: "New Visit",
                      child: Text("New Visit"),
                    ),
                    DropdownMenuItem(
                      value: "Corporate Visit",
                      child: Text("Corporate Visit"),
                    ),
                    DropdownMenuItem(
                      value: "LCO Visit",
                      child: Text("LCO Visit"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      visitType = value;
                    });
                  },
                ),
                gap(),

                /// LCO / CORPORATE NAME
                title("LCO / Corporate Name"),
                TextField(
                  controller: companyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// LEAD
                title("Lead"),
                DropdownButtonFormField<String>(
                  value: lead,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  hint: const Text("-- Select one --"),
                  items: const [
                    DropdownMenuItem(value: "Lead 1", child: Text("Lead 1")),
                    DropdownMenuItem(value: "Lead 2", child: Text("Lead 2")),
                    DropdownMenuItem(value: "Lead 3", child: Text("Lead 3")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      lead = value;
                    });
                  },
                ),
                gap(),

                /// CONTACT NO
                title("Contact No"),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// ADDRESS
                title("Address"),
                TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// PINCODE
                title("Pincode"),
                TextField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// NEAREST HUB
                title("Nearest Hub"),
                DropdownButtonFormField<String>(
                  value: nearestHub,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  hint: const Text("-- Select Nearest Hub --"),
                  items: const [
                    DropdownMenuItem(
                      value: "Bhawanipur Hub",
                      child: Text("Bhawanipur Hub"),
                    ),
                    DropdownMenuItem(
                      value: "Kasba Hub",
                      child: Text("Kasba Hub"),
                    ),
                    DropdownMenuItem(
                      value: "Shanpur Hub",
                      child: Text("Shanpur Hub"),
                    ),
                    DropdownMenuItem(
                      value: "Malanga Hub",
                      child: Text("Malanga Hub"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      nearestHub = value;
                    });
                  },
                ),
                gap(),

                /// PROBLEM TYPE
                title("Problem Type"),
                DropdownButtonFormField<String>(
                  value: problemType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  hint: const Text("-- Select one --"),
                  items: const [
                    DropdownMenuItem(
                      value: "Network Related",
                      child: Text("Network Related"),
                    ),
                    DropdownMenuItem(
                      value: "Speed Issue",
                      child: Text("Speed Issue"),
                    ),
                    DropdownMenuItem(
                      value: "IP Configure",
                      child: Text("IP Configure"),
                    ),
                    DropdownMenuItem(
                      value: "New LCO Visit",
                      child: Text("New LCO Visit"),
                    ),
                    DropdownMenuItem(
                      value: "Corporate Visit",
                      child: Text("Corporate Visit"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      problemType = value;
                    });
                  },
                ),
                gap(),

                /// IN TIME
                title("In Time"),
                TextField(
                  controller: inTimeController,
                  readOnly: true,
                  onTap: () => pickTime(inTimeController),
                  decoration: InputDecoration(
                    hintText: "--:-- --",
                    suffixIcon: const Icon(Icons.access_time),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// OUT TIME
                title("Out Time"),
                TextField(
                  controller: outTimeController,
                  readOnly: true,
                  onTap: () => pickTime(outTimeController),
                  decoration: InputDecoration(
                    hintText: "--:-- --",
                    suffixIcon: const Icon(Icons.access_time),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                gap(),

                /// FEEDBACK
                title("Feedback"),
                DropdownButtonFormField<String>(
                  value: feedback,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  hint: const Text("-- Select one --"),
                  items: const [
                    DropdownMenuItem(value: "Solve", child: Text("Solve")),
                    DropdownMenuItem(value: "Pending", child: Text("Pending")),
                    DropdownMenuItem(
                      value: "Positive for Feasibility",
                      child: Text("Positive for Feasibility"),
                    ),
                    DropdownMenuItem(
                      value: "Need Follow Up",
                      child: Text("Need Follow Up"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      feedback = value;
                    });
                  },
                ),
                gap(),

                /// REMARKS
                title("Remarks"),
                TextField(
                  controller: remarksController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// DOCUMENT TABLE - FIXED WITH HORIZONTAL SCROLL
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Wrap with SingleChildScrollView for horizontal scroll
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width - 60,
                          ),
                          child: Column(
                            children: [
                              // Table Header
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xff151A63),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Document Type
                                    Container(
                                      width: 140,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Document Type",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    // Description
                                    Container(
                                      width: 140,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Description",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    // Document
                                    Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Document",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    // Add Button
                                    Container(
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: addDocumentRow,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Document Rows
                              ...documentRows.asMap().entries.map((entry) {
                                int index = entry.key;
                                DocumentRow row = entry.value;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey.shade50,
                                    border: Border(
                                      bottom: index == documentRows.length - 1
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Document Type Dropdown
                                      Container(
                                        width: 140,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          value: row.documentType,
                                          isDense: true,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 4,
                                                ),
                                          ),
                                          hint: const Text(
                                            "Type",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "Photo",
                                              child: Text(
                                                "Photo",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "PDF",
                                              child: Text(
                                                "PDF",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Video",
                                              child: Text(
                                                "Video",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Document",
                                              child: Text(
                                                "Document",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              row.documentType = value;
                                            });
                                          },
                                        ),
                                      ),

                                      // Description TextField
                                      Container(
                                        width: 140,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: TextField(
                                          controller: row.descriptionController,
                                          style: const TextStyle(fontSize: 12),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Description",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 4,
                                                ),
                                          ),
                                          onChanged: (value) {
                                            row.description = value;
                                          },
                                        ),
                                      ),

                                      // Upload Button
                                      Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xff151A63,
                                            ),
                                            minimumSize: const Size(0, 30),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          onPressed: () {
                                            _showFilePicker(row);
                                          },
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.upload_file,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Upload",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Delete Button
                                      Container(
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: documentRows.length > 1
                                              ? () => removeDocumentRow(index)
                                              : null,
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: documentRows.length > 1
                                                ? Colors.red
                                                : Colors.grey.shade300,
                                            size: 18,
                                          ),
                                          tooltip: "Remove row",
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: 140,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      _createDVR();
                    },
                    child: const Text(
                      "Create DVR",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilePicker(DocumentRow row) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("File upload feature - implement your file picker here"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _createDVR() {
    // Validate all fields
    if (visitType == null) {
      _showError("Please select Visit Type");
      return;
    }
    if (companyController.text.isEmpty) {
      _showError("Please enter LCO / Corporate Name");
      return;
    }
    if (lead == null) {
      _showError("Please select Lead");
      return;
    }
    if (contactController.text.isEmpty) {
      _showError("Please enter Contact Number");
      return;
    }
    if (addressController.text.isEmpty) {
      _showError("Please enter Address");
      return;
    }
    if (pincodeController.text.isEmpty) {
      _showError("Please enter Pincode");
      return;
    }
    if (nearestHub == null) {
      _showError("Please select Nearest Hub");
      return;
    }
    if (problemType == null) {
      _showError("Please select Problem Type");
      return;
    }
    if (inTimeController.text.isEmpty) {
      _showError("Please select In Time");
      return;
    }
    if (outTimeController.text.isEmpty) {
      _showError("Please select Out Time");
      return;
    }
    if (feedback == null) {
      _showError("Please select Feedback");
      return;
    }

    // Check if at least one document row has data
    bool hasDocument = false;
    for (var row in documentRows) {
      if (row.documentType != null ||
          row.descriptionController.text.isNotEmpty) {
        hasDocument = true;
        break;
      }
    }

    if (!hasDocument) {
      _showError("Please add at least one document");
      return;
    }

    // Create DVR object
    Map<String, dynamic> dvrData = {
      'date': dateController.text,
      'visitType': visitType,
      'companyName': companyController.text,
      'lead': lead,
      'contactNo': contactController.text,
      'address': addressController.text,
      'pincode': pincodeController.text,
      'nearestHub': nearestHub,
      'problemType': problemType,
      'inTime': inTimeController.text,
      'outTime': outTimeController.text,
      'feedback': feedback,
      'remarks': remarksController.text,
      'documents': documentRows
          .map(
            (row) => {
              'type': row.documentType,
              'description': row.description,
              'file': row.fileName,
            },
          )
          .toList(),
    };

    // Show success
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: const Text("DVR Created Successfully!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    print("DVR Data: $dvrData");
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Document Row Model
class DocumentRow {
  String? documentType;
  String description = '';
  String? fileName;
  final TextEditingController descriptionController = TextEditingController();

  DocumentRow({this.documentType, this.fileName});

  void dispose() {
    descriptionController.dispose();
  }
}
