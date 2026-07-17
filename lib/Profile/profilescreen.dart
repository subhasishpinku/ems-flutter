import 'package:flutter/material.dart';
import 'package:ems/Profile/utils/profile_colors.dart';
import 'package:ems/Profile/widgets/profile_button.dart';
import 'package:ems/Profile/widgets/profile_image.dart';
import 'package:ems/Profile/widgets/profile_textfield.dart';

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

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: "Sumon Sardar");
    email = TextEditingController(text: "sumon.sardar@bacbpl.com");
    phone = TextEditingController(text: "9433253566");
    dob = TextEditingController(text: "02/27/1987");
    password = TextEditingController(text: "12345");
    joining = TextEditingController(text: "03/19/2024");
    address = TextEditingController(
      text:
          "Dakshin, R.C.Thakurani, Chak Ramnagar, Kolkata, West Bengal, India, 700104",
    );
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   title: const Text("Profile"),
      //   centerTitle: true,
      //   backgroundColor: primaryColor,
      // ),
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
              const ProfileImage(),

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
                obscure: true,
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
                onTap: () {
                  // Update Profile API
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
