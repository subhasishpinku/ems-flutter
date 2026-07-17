import 'package:flutter/material.dart';

class OtherSubmitTab extends StatefulWidget {
  const OtherSubmitTab({super.key});

  @override
  State<OtherSubmitTab> createState() => _OtherSubmitTabState();
}

class _OtherSubmitTabState extends State<OtherSubmitTab> {
  final TextEditingController planController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  bool moneyCollected = false;
  bool installationCompleted = true;

  String selectedPaymentMode = "Cash";

  final List<String> paymentModes = [
    "Cash",
    "Online",
    "Cheque",
    "UPI"
  ];

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
                "Other / Submit",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: planController,
                decoration: const InputDecoration(
                  labelText: "Plan Details",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: paymentController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Money Collected",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: selectedPaymentMode,
                decoration: const InputDecoration(
                  labelText: "Payment Mode",
                  border: OutlineInputBorder(),
                ),
                items: paymentModes
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMode = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              CheckboxListTile(
                value: moneyCollected,
                title: const Text("Money Collected"),
                onChanged: (value) {
                  setState(() {
                    moneyCollected = value!;
                  });
                },
              ),

              CheckboxListTile(
                value: installationCompleted,
                title: const Text("Installation Completed"),
                onChanged: (value) {
                  setState(() {
                    installationCompleted = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: remarkController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Installation Remark",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Upload feature coming soon"),
                    ),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Vendor Bill"),
              ),

              const SizedBox(height: 35),

              Row(
                children: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(2);
                    },
                    child: const Text(
                      "Previous",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Installation Created Successfully"),
                        ),
                      );

                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Create",
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