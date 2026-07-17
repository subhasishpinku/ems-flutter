import 'package:ems/Hub/hunscreen.dart';
import 'package:ems/Lco/lcoscreen.dart';
import 'package:ems/Profile/profilescreen.dart';
import 'package:ems/view/Dashboard/Page1.dart';
import 'package:ems/view/Dashboard/widgets/CustomDrawer.dart';
import 'package:ems/view/Dashboard/widgets/buildmynavbar.dart';
import 'package:ems/view/Home/homescreen.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dashboard> {
  final String title = "HAYAT";
  int pageIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
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
                offset: Offset(0, 2),
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
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       pageIndex = 0;
                  //     });
                  //   },
                  //   child: Container(
                  //     height: 38,
                  //     width: 38,
                  //     decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: const Icon(
                  //       Icons.home_outlined,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
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
      drawer: const CustomDrawer(),
    );
  }
}
