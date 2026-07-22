import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        children: [
          _buildForm(),
          const Center(child: Text("Maintenance")),
        ],
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
              _label("NETWORK"),
              _dropdown(
                value: network,
                items: networks,
                onChanged: (v) => setState(() => network = v!),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("CONNECTION TYPE"),
                        _dropdown(
                          value: connection,
                          items: connectionTypes,
                          onChanged: (v) => setState(() => connection = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
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
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
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
              _dropdown(
                value: problem,
                items: problems,
                onChanged: (v) => setState(() => problem = v!),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _label("TEAM LEADER"),
                        _dropdown(
                          value: leader,
                          items: leaders,
                          onChanged: (v) => setState(() => leader = v!),
                        ),
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
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
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
}
