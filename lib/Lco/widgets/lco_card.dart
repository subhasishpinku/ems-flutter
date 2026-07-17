import 'package:flutter/material.dart';

class LcoCard extends StatelessWidget {
  final String networkName;
  final String contactPerson;
  final String address;
  final String pincode;
  final String phone;
  final String alternateNo;
  final String email;
  final String latitude;
  final String longitude;
  final String type;
  final String hubOne;
  final String hubTwo;
  final String fieldEngineer;
  final String status;

  const LcoCard({
    super.key,
    required this.networkName,
    required this.contactPerson,
    required this.address,
    required this.pincode,
    required this.phone,
    required this.alternateNo,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.hubOne,
    required this.hubTwo,
    required this.fieldEngineer,
    required this.status,
  });

  Widget row(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 18),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.router, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    networkName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            row("Contact", contactPerson, Icons.person),
            row("Address", address, Icons.location_on),
            row("Pincode", pincode, Icons.pin_drop),
            row("Phone", phone, Icons.phone),
            row("Alternate", alternateNo, Icons.call),
            row("Email", email, Icons.email),
            row("Latitude", latitude, Icons.map),
            row("Longitude", longitude, Icons.place),
            row("Type", type, Icons.category),
            row("Hub One", hubOne, Icons.hub),
            row("Hub Two", hubTwo, Icons.hub_outlined),
            row("Engineer", fieldEngineer, Icons.engineering),
            row("Status", status, Icons.verified),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                    label: const Text("View"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}