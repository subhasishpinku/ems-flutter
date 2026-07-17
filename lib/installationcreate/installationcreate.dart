import 'package:flutter/material.dart';
import 'tabs/installation_tab.dart';
import 'tabs/hubs_tab.dart';
import 'tabs/materials_tab.dart';
import 'tabs/other_submit_tab.dart';

class InstallationCreate extends StatelessWidget {
  const InstallationCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xfff5f7fb),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: const TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.blue,
                  tabs: [
                    Tab(text: "Installation"),
                    Tab(text: "Hubs"),
                    Tab(text: "Materials"),
                    Tab(text: "Other / Submit"),
                  ],
                ),
              ),

              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    InstallationTab(),
                    HubsTab(),
                    MaterialsTab(),
                    OtherSubmitTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
