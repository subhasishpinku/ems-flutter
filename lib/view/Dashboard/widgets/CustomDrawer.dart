import 'package:ems/Docket/DocketCreate/docket_create.dart';
import 'package:ems/Docket/HoldRelese/hold_relese.dart';
import 'package:ems/Docket/MaterialUse/material_use.dart';
import 'package:ems/Docket/Start/docket_start.dart';
import 'package:ems/Docket/Tranfer/tranfer.dart';
import 'package:ems/Docket/VehicleFuledMovement/vehicle_fuled_movement.dart';
import 'package:ems/Docket/close/docket_close.dart';
import 'package:ems/Dvr/dvr_screen.dart';
import 'package:ems/FieldSheet/fieldsheet.dart';
import 'package:ems/Lead/leadscreen.dart';
import 'package:ems/LeaveApplication/leaveapplication.dart';
import 'package:ems/core/services/auth_service.dart';
import 'package:ems/view/LoginScreen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ems/view/Home/providers/home_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HomeProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // const UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(color: Colors.blue),
          //   accountName: Text("Subhasish Singha"),
          //   accountEmail: Text("pinku.subhasish@gmail.com"),
          //   currentAccountPictureSize: Size.square(50),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     child: Text(
          //       "HI",
          //       style: TextStyle(
          //         fontSize: 30,
          //         color: Colors.blue,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),

            accountName: Text(
              provider.profile?.empName ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            accountEmail: Text(provider.profile?.email ?? ""),

            currentAccountPictureSize: const Size.square(60),

            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,

              backgroundImage:
                  provider.profile != null &&
                      provider.profile!.profileImage.isNotEmpty
                  ? NetworkImage(
                      "https://ems.ueplnet.com${provider.profile!.profileImage}",
                    )
                  : null,

              child:
                  provider.profile == null ||
                      provider.profile!.profileImage.isEmpty
                  ? Text(
                      provider.profile?.empName.isNotEmpty == true
                          ? provider.profile!.empName[0].toUpperCase()
                          : "U",
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
          // Lead
          // ListTile(
          //   leading: const Icon(Icons.people_alt_outlined),
          //   title: const Text('Lead'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const LeadScreen()),
          //     );
          //   },
          // ),

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
          // ListTile(
          //   leading: const Icon(Icons.task_alt_outlined),
          //   title: const Text('Task Manager'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),

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
          // ListTile(
          //   leading: const Icon(Icons.event_note_outlined),
          //   title: const Text('DVR'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const DvrScreen()),
          //     );
          //   },
          // ),

          // Leave Report
          // ListTile(
          //   leading: const Icon(Icons.assessment_outlined),
          //   title: const Text('Leave Report'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ExpansionTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Docket"),
            childrenPadding: const EdgeInsets.only(left: 20),
            children: [
              ListTile(
                title: const Text("Create"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DocketCreate(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Hold/Release"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HoldRelese()),
                  );
                },
              ),
              ListTile(
                title: const Text("Transfer"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Tranfer()),
                  );
                },
              ),
              ListTile(
                title: const Text("Start"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DocketStart(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Close"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DocketClose(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Material Use"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialUse(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Vehicle & Fuel Movement"),
                onTap: () {
                  // Navigator.push(...);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VehicleFuledMovement(),
                    ),
                  );
                },
              ),
            ],
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

                  try {
                    final refreshResponse = await AuthService().refreshToken();

                    if (refreshResponse.data["status"] == "success") {
                      final prefs = await SharedPreferences.getInstance();

                      // Save new token
                      await prefs.setString(
                        "token",
                        refreshResponse.data["data"]["token"],
                      );

                      // Retry logout
                      final logoutResponse = await AuthService().logout();

                      if (logoutResponse.data["status"] == "success") {
                        await prefs.clear();

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(refreshResponse.data["message"]),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
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
