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
        children: [_buildForm(), _buildForm1()],
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

                        // যদি circuit detail API call করতে হয়
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
                        _dropdown(
                          value: technician,
                          items: technicians,
                          onChanged: (v) => setState(() => technician = v!),
                        ),
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
                child: SizedBox(
                  height: 42,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Create
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Create",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(width: 10),

                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showDetails = !showDetails;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: showDetails
                                ? Colors.red
                                : Colors.blue,
                          ),
                          child: Text(
                            showDetails ? "Hide Details" : "Detail",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm1() {
    return Column(
      children: [
        _buildSectionCard(
          title: "Docket Type",
          child: Wrap(
            spacing: 20,
            runSpacing: 15,
            children: [
              _buildTextField("Connection Type"),
              _buildTextField("Area"),
              _buildTextField("Circuit ID"),
              _buildTextField("Status"),
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
              _buildTextField("Location A"),
              _buildTextField("Mobile"),
              _buildTextField("Address Line A", width: 450),
              _buildTextField("Pin"),
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
              _buildTextField("Network Name", width: 450),
              _buildTextField("Mobile"),
              _buildTextField("Address Line B"),
              _buildTextField("Pin"),
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
              _buildTextField("Customer Name", width: 450),
              _buildTextField("Customer Contact", width: 450),
            ],
          ),
        ),
      ],
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

  Widget _buildTextField(String hint, {double width = 220}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
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
}
