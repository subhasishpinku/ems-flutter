import 'package:ems/Hub/widgets/hub_list.dart';
import 'package:flutter/material.dart';
import 'widgets/hub_action_buttons.dart';
import 'widgets/hub_dropdown.dart';
import 'widgets/hub_header.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  String? type;
  String? hubName;
  String? contactPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const HubHeader(),

              const SizedBox(height: 20),

              HubDropdown(
                label: "TYPE",
                hint: "-- Select one --",
                value: type,
                items: const ["Distributor", "Dealer", "Network"],
                onChanged: (v) {
                  setState(() => type = v);
                },
              ),

              const SizedBox(height: 15),

              HubDropdown(
                label: "HUB NAME",
                hint: "All Network Name",
                value: hubName,
                items: const ["Hub 1", "Hub 2", "Hub 3"],
                onChanged: (v) {
                  setState(() => hubName = v);
                },
              ),

              const SizedBox(height: 15),

              HubDropdown(
                label: "CONTACT PERSON",
                hint: "All Contact Persons",
                value: contactPerson,
                items: const ["John", "Alex", "David"],
                onChanged: (v) {
                  setState(() => contactPerson = v);
                },
              ),

              const SizedBox(height: 20),

              const HubActionButtons(),
              const SizedBox(height: 20),

              const HubList(),
            ],
          ),
        ),
      ),
    );
  }
}
