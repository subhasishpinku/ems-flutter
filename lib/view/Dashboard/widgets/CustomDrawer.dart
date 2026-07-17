import 'package:ems/Dvr/dvr_screen.dart';
import 'package:ems/FieldSheet/fieldsheet.dart';
import 'package:ems/Lead/leadscreen.dart';
import 'package:ems/LeaveApplication/leaveapplication.dart';
import 'package:ems/core/services/auth_service.dart';
import 'package:ems/view/LoginScreen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text("Subhasish Singha"),
            accountEmail: Text("pinku.subhasish@gmail.com"),
            currentAccountPictureSize: Size.square(50),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "HI",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Lead
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('Lead'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LeadScreen()),
              );
            },
          ),

          // Field Sheet
          ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Field Sheet'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FieldSheetScreen(),
                ),
              );
            },
          ),

          // Task Manager
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            title: const Text('Task Manager'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // Leave Application
          ListTile(
            leading: const Icon(Icons.event_note_outlined),
            title: const Text('Leave Application'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaveApplication(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_note_outlined),
            title: const Text('DVR'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DvrScreen()),
              );
            },
          ),
          // Leave Report
          ListTile(
            leading: const Icon(Icons.assessment_outlined),
            title: const Text('Leave Report'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              try {
                final response = await AuthService().logout();

                if (response.data["status"] == "success") {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.clear();

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response.data["message"])),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
        ],
      ),
    );
  }
}
