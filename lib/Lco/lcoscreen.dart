import 'package:ems/Lco/widgets/lco_list.dart';
import 'package:flutter/material.dart';
import 'widgets/lco_action_buttons.dart';
import 'widgets/lco_dropdown.dart';
import 'widgets/lco_header.dart';

class LcoScreen extends StatefulWidget {
  const LcoScreen({super.key});

  @override
  State<LcoScreen> createState() => _LcoScreenState();
}

class _LcoScreenState extends State<LcoScreen> {
  String? type;
  String? network;
  String? contactPerson;
  String? fieldEngineer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const LcoHeader(),

              const SizedBox(height: 20),

              LcoDropdown(
                label: "TYPE",
                hint: "-- Select one --",
                value: type,
                items: const ["Distributor", "Hub", "LCO"],
                onChanged: (value) {
                  setState(() => type = value);
                },
              ),

              const SizedBox(height: 15),

              LcoDropdown(
                label: "NETWORK NAME",
                hint: "All Network Name",
                value: network,
                items: const ["Network 1", "Network 2", "Network 3"],
                onChanged: (value) {
                  setState(() => network = value);
                },
              ),

              const SizedBox(height: 15),

              LcoDropdown(
                label: "CONTACT PERSON",
                hint: "All Contact Persons",
                value: contactPerson,
                items: const ["John", "Alex", "David"],
                onChanged: (value) {
                  setState(() => contactPerson = value);
                },
              ),

              const SizedBox(height: 15),

              LcoDropdown(
                label: "FIELD ENGINEER",
                hint: "All Field Engineers",
                value: fieldEngineer,
                items: const ["Engineer 1", "Engineer 2", "Engineer 3"],
                onChanged: (value) {
                  setState(() => fieldEngineer = value);
                },
              ),

              const SizedBox(height: 20),

              const LcoActionButtons(),
              const SizedBox(height: 20),

              const LcoList(),
            ],
          ),
        ),
      ),
    );
  }
}
