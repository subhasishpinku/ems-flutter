import 'package:flutter/material.dart';
import 'package:ems/Profile/widgets/profile_button.dart';
import 'package:ems/Profile/widgets/profile_image.dart';
import 'package:ems/Profile/widgets/profile_textfield.dart';
import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController dob;
  late TextEditingController password;
  late TextEditingController joining;
  late TextEditingController address;

  String? imagePath;
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    dob = TextEditingController();
    password = TextEditingController();
    joining = TextEditingController();
    address = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    dob.dispose();
    password.dispose();
    joining.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.profile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!loaded) {
          loaded = true;

          name.text = provider.profile!.empName;
          email.text = provider.profile!.email;
          phone.text = provider.profile!.phone;
          dob.text = provider.profile!.dob;
          joining.text = provider.profile!.joiningDate;
          address.text = provider.profile!.address;
          password.text = provider.profile!.password;
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ProfileImage(
                    image: provider.profile?.profileImage ?? "",
                    onImageSelected: (path) {
                      imagePath = path;
                      print("Selected Image = $imagePath");
                    },
                  ),

                  const SizedBox(height: 25),

                  ProfileTextField(
                    controller: name,
                    label: "Name",
                    icon: Icons.person,
                  ),

                  ProfileTextField(
                    controller: email,
                    label: "Email",
                    icon: Icons.email,
                  ),

                  ProfileTextField(
                    controller: phone,
                    label: "Phone",
                    icon: Icons.phone,
                  ),

                  ProfileTextField(
                    controller: dob,
                    label: "Date of Birth",
                    icon: Icons.calendar_today,
                  ),

                  ProfileTextField(
                    controller: password,
                    label: "Password",
                    icon: Icons.lock,
                    obscure: false,
                  ),

                  ProfileTextField(
                    controller: joining,
                    label: "Date of Joining",
                    icon: Icons.calendar_month,
                  ),

                  ProfileTextField(
                    controller: address,
                    label: "Address",
                    icon: Icons.location_on,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 25),

                  ProfileButton(
                    title: "UPDATE",
                    onTap: () async {
                      try {
                        await provider.updateProfile(
                          name: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          password: password.text.trim(),
                          dob: dob.text.trim(),
                          joining: joining.text.trim(),
                          address: address.text.trim(),
                          imagePath: imagePath,
                        );

                        loaded = false;

                        await provider.loadProfile();

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profile Updated Successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
