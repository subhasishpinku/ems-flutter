import 'package:ems/Docket/provider/docket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocketCreate extends StatefulWidget {
  const DocketCreate({super.key});

  @override
  State<DocketCreate> createState() => _DocketCreateState();
}

class _DocketCreateState extends State<DocketCreate>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> networks = ["-- Select one --", "Network 1", "Network 2"];

  final List<String> connectionTypes = [
    "-- Select one --",
    "FTTH",
    "Broadband",
  ];

  final List<String> problems = [
    "-- Select one --",
    "No Internet",
    "Slow Speed",
    "Cable Damage",
  ];

  final List<String> leaders = ["-- Select one --", "Leader 1", "Leader 2"];

  final List<String> technicians = [
    "-- Select one --",
    "Technician 1",
    "Technician 2",
  ];

  String network = "-- Select one --";
  String connection = "-- Select one --";
  String problem = "-- Select one --";
  String leader = "-- Select one --";
  String technician = "-- Select one --";

  final circuitController = TextEditingController();
  final requestController = TextEditingController();
  final contactController = TextEditingController();
  final remarksController = TextEditingController();
  bool showDetails = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      final provider = context.read<DocketProvider>();

      provider.loadNetworks();
      provider.loadConnectionTypes();
      provider.loadTeamLeaders();
      provider.loadTechnicians();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    circuitController.dispose();
    requestController.dispose();
    contactController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black87,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: "Normal"),
            Tab(text: "Maintenance"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildForm(), _buildMaintenanceForm()],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // _label("NETWORK"),
              // _dropdown(
              //   value: network,
              //   items: networks,
              //   onChanged: (v) => setState(() => network = v!),
              // ),
              _label("NETWORK"),
              _buildNetworkDropdown(),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("CONNECTION TYPE"),
                        // _dropdown(
                        //   value: connection,
                        //   items: connectionTypes,
                        //   onChanged: (v) => setState(() => connection = v!),
                        // ),
                        _buildConnectionDropdown(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _label("CIRCUIT ID"),
                        Consumer<DocketProvider>(
                          builder: (context, provider, child) {
                            circuitController.text = provider.circuitId;

                            return _textField(
                              controller: circuitController,
                              hint: "Circuit ID",
                            );
                          },
                        ),
                        // _textField(
                        //   controller: circuitController,
                        //   hint: "Circuit ID",
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final provider = context.read<DocketProvider>();

                        await provider.loadCircuitDetail();

                        setState(() {
                          showDetails = true;
                        });
                      },
                      icon: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: showDetails ? _buildForm1() : const SizedBox.shrink(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Docket creation details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("REQUEST BY"),
                        _textField(
                          controller: requestController,
                          hint: "Request By",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _label("CONTACT NO"),
                        _textField(
                          controller: contactController,
                          hint: "Contact No",
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _label("PROBLEM"),
              _buildProblemDropdown(), // _dropdown(
              //   value: problem,
              //   items: problems,
              //   onChanged: (v) => setState(() => problem = v!),
              // ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("TEAM LEADER"),
                        _buildTeamLeaderDropdown(),
                        // _dropdown(
                        //   value: leader,
                        //   items: leaders,
                        //   onChanged: (v) => setState(() => leader = v!),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _label("TECHNICIAN"),
                        _label("TECHNICIAN"),
                        _buildTechnicianDropdown(),
                        // _dropdown(value: technician, items: technicians),
                        // _dropdown(
                        //   value: technician,
                        //   items: technicians,
                        //   onChanged: (v) => setState(() => technician = v!),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _label("REMARKS"),
              _textField(
                controller: remarksController,
                hint: "Remarks",
                maxLines: 2,
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final provider = context.read<DocketProvider>();

                        final response = await provider.createDocket(
                          requestBy: requestController.text,
                          contactNo: contactController.text,
                          remarks: remarksController.text,
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response["message"] ?? "Something went wrong",
                            ),
                            backgroundColor: response["status"] == "success"
                                ? Colors.green
                                : Colors.red,
                          ),
                        );

                        if (response["status"] == "success") {
                          // চাইলে form clear করতে পারো
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showDetails = !showDetails;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showDetails ? Colors.red : Colors.blue,
                      ),
                      child: Text(
                        showDetails ? "Hide Details" : "Details",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm1() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        final detail = provider.circuitDetail;

        if (detail == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("No data found", style: TextStyle(fontSize: 16)),
            ),
          );
        }

        return Column(
          children: [
            _buildSectionCard(
              title: "Docket Type",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField(
                    "Connection Type",
                    detail.connectionType ?? "",
                  ),
                  _buildTextField("Area", detail.hirerName ?? ""),
                  _buildTextField("Circuit ID", detail.circuitId ?? ""),
                  _buildTextField("Status", detail.status ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 15),

            _buildSectionCard(
              title: "Location A",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField("Location A", detail.locationA ?? ""),
                  _buildTextField("Mobile", detail.mobileA ?? ""),
                  _buildTextField(
                    "Address Line A",
                    detail.addressA ?? "",
                    width: 450,
                  ),
                  _buildTextField("Pin", detail.pinA ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 15),

            _buildSectionCard(
              title: "Location B",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField("Location B", detail.locationB ?? ""),
                  _buildTextField("Mobile", detail.mobileB ?? ""),
                  _buildTextField(
                    "Address Line B",
                    detail.addressB ?? "",
                    width: 450,
                  ),
                  _buildTextField("Pin", detail.pinB ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 15),

            _buildSectionCard(
              title: "Contact",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField(
                    "Customer Name",
                    detail.customerName ?? "",
                    width: 450,
                  ),
                  _buildTextField(
                    "Customer Contact",
                    detail.customerContact ?? "",
                    width: 450,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildConnectionDropdown() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          value: provider.selectedConnection,
          hint: const Text("Select Connection"),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: provider.connectionTypes.map((item) {
            return DropdownMenuItem(value: item.value, child: Text(item.label));
          }).toList(),
          onChanged: provider.changeConnection,
        );
      },
    );
  }

  Widget _buildTechnicianDropdown() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          value: provider.selectedTechnician,
          hint: const Text("Select Technician"),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: provider.technicians.map((tech) {
            return DropdownMenuItem(value: tech.value, child: Text(tech.label));
          }).toList(),
          onChanged: provider.changeTechnician,
        );
      },
    );
  }

  Widget _buildNetworkDropdown() {
    return SizedBox(
      width: 220,
      child: Consumer<DocketProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return DropdownButtonFormField<String>(
            value: provider.selectedNetwork,
            isExpanded: true,
            hint: const Text("Select Network"),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            items: provider.networks.map((network) {
              return DropdownMenuItem<String>(
                value: network.value,
                child: Text(network.label),
              );
            }).toList(),
            onChanged: provider.changeNetwork,
          );
        },
      ),
    );
  }

  Widget _buildProblemDropdown() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          value: provider.selectedProblem,
          hint: const Text("Select Problem"),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          items: provider.problems.map((problem) {
            return DropdownMenuItem<String>(
              value: problem.value,
              child: Text(problem.label),
            );
          }).toList(),
          onChanged: provider.changeProblem,
        );
      },
    );
  }

  Widget _buildTeamLeaderDropdown() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          value: provider.selectedTeamLeader,
          hint: const Text("Select Team Leader"),
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: provider.teamLeaders.map((leader) {
            return DropdownMenuItem<String>(
              value: leader.value,
              child: Text(leader.label),
            );
          }).toList(),
          onChanged: provider.changeTeamLeader,
        );
      },
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true, // <-- এটা যোগ করুন
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e, overflow: TextOverflow.ellipsis, maxLines: 1),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField(String label, String value, {double width = 220}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return SizedBox(
      width: 220,
      child: DropdownButtonFormField<String>(
        value: "-- Select one --",
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: "-- Select one --",
            child: Text("-- Select one --"),
          ),
          DropdownMenuItem(value: "Option 1", child: Text("Option 1")),
          DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildMaintenanceForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 10),

              _label("NETWORK"),
              _buildNetworkDropdown(),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("CONNECTION TYPE"),
                        _buildConnectionDropdown(),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      children: [
                        _label("CIRCUIT ID"),

                        Consumer<DocketProvider>(
                          builder: (context, provider, child) {
                            circuitController.text = provider.circuitId;

                            return _textField(
                              controller: circuitController,
                              hint: "Circuit ID",
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () async {
                        final provider = context.read<DocketProvider>();

                        await provider.loadCircuitDetail();

                        setState(() {
                          showDetails = true;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: showDetails
                    ? _buildMaintenanceDetails()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenanceDetails() {
    return Consumer<DocketProvider>(
      builder: (context, provider, child) {
        final detail = provider.circuitDetail;

        if (detail == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("No data found"),
            ),
          );
        }

        return Column(
          children: [
            // Docket Type
            _buildSectionCard(
              title: "Docket Type",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  SizedBox(
                    width: 220,
                    child: Column(
                      children: [
                        _label("CONNECTION TYPE"),
                        _buildConnectionDropdown(),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 220,
                    child: Column(
                      children: [
                        _label("CIRCUIT ID"),
                        _textField(
                          controller: circuitController,
                          hint: "Circuit ID",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 220,
                    child: Column(
                      children: [
                        _label("STATUS"),
                        _dropdown(
                          value: "-- Select one --",
                          items: const [
                            "-- Select one --",
                            "Open",
                            "Pending",
                            "Closed",
                          ],
                          onChanged: (v) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Location A
            _buildSectionCard(
              title: "Location A",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField("Location A", detail.locationA ?? ""),
                  _buildTextField("Mobile", detail.mobileA ?? ""),
                  _buildTextField(
                    "Address Line A",
                    detail.addressA ?? "",
                    width: 320,
                  ),
                  _buildTextField("Pin", detail.pinA ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Network Details
            _buildSectionCard(
              title: "Network Details",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField("Network Name", detail.locationB ?? ""),
                  _buildTextField("Mobile", detail.mobileB ?? ""),
                  _buildTextField(
                    "Address Line",
                    detail.addressB ?? "",
                    width: 320,
                  ),
                  _buildTextField("Pin", detail.pinB ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Contact
            _buildSectionCard(
              title: "Contact",
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _buildTextField(
                    "Customer Name",
                    detail.customerName ?? "",
                    width: 320,
                  ),
                  _buildTextField(
                    "Customer Contact",
                    detail.customerContact ?? "",
                    width: 320,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Docket Creation Details
            _buildSectionCard(
              title: "Docket creation details",
              child: Column(
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _label("REQUEST BY"),
                            _textField(
                              controller: requestController,
                              hint: "Request By",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _label("CONTACT NO"),
                            _textField(
                              controller: contactController,
                              hint: "Contact No",
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _label("PROBLEM"),
                            _buildProblemDropdown(),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _label("TEAM LEADER"),
                            _buildTeamLeaderDropdown(),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _label("TECHNICIAN"),
                            _buildTechnicianDropdown(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _label("REMARKS"),
                  _textField(
                    controller: remarksController,
                    hint: "Remarks",
                    maxLines: 2,
                  ),

                  const SizedBox(height: 25),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () async {
                        final provider = context.read<DocketProvider>();

                        final response = await provider.createDocket(
                          requestBy: requestController.text,
                          contactNo: contactController.text,
                          remarks: remarksController.text,
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response["message"]),
                            backgroundColor: response["status"] == "success"
                                ? Colors.green
                                : Colors.red,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
