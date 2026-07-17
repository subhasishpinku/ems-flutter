import 'package:ems/Hub/hunscreen.dart';
import 'package:ems/Lco/lcoscreen.dart';
import 'package:ems/LeadReport/leadreport.dart';
import 'package:ems/Profile/profilescreen.dart';
import 'package:ems/installationcreate/installationcreate.dart';
import 'package:ems/view/Dashboard/widgets/buildmynavbar.dart';
import 'package:ems/view/Home/homescreen.dart';
import 'package:flutter/material.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  int pageIndex = 0;

  final List<Widget> pages = [
    const LeadContent(), // This will show leads
    const HubScreen(),
    const LcoScreen(),
    const ProfileScreen(),
  ];

  void _onPageSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.blue,
            surfaceTintColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            toolbarHeight: 70,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "assets/logo.png",
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: BuildMyNavBar(
        pageIndex: pageIndex,
        onPageSelected: _onPageSelected,
      ),
    );
  }
}

// Lead Content Widget

class LeadContent extends StatelessWidget {
  const LeadContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Lead",
        "icon": Icons.groups,
        "color": Colors.blue,
        "screen": const InstallationCreate(),
      },
      {
        "title": "Feasibility",
        "icon": Icons.engineering,
        "color": Colors.red,
        "screen": const HubScreen(),
      },
      {
        "title": "Installation",
        "icon": Icons.receipt_long,
        "color": Colors.deepPurple,
        "screen": const InstallationCreate(),
      },
      {
        "title": "Leads Report",
        "icon": Icons.assignment,
        "color": Colors.blue,
        "screen": const LeadReport(),
      },
      {
        "title": "Feasibility Report",
        "icon": Icons.description,
        "color": Colors.blue,
        "screen": const ProfileScreen(),
      },
      {
        "title": "Installation Report",
        "icon": Icons.article,
        "color": Colors.blue,
        "screen": const ProfileScreen(),
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 140,
          runSpacing: 35,
          alignment: WrapAlignment.spaceBetween,
          children: menuItems.map((item) {
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item["screen"] as Widget),
                );
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: item["color"] as Color,
                      child: Icon(
                        item["icon"] as IconData,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item["title"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
