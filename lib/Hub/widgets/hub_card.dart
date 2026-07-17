import 'package:flutter/material.dart';

class HubCard extends StatelessWidget {
  final String hubName;
  final String contactPerson;
  final String address;
  final String pin;
  final String phone;
  final String alternateNo;
  final String email;
  final String latitude;
  final String longitude;
  final String status;
  final String type;
  final String rent;

  const HubCard({
    super.key,
    required this.hubName,
    required this.contactPerson,
    required this.address,
    required this.pin,
    required this.phone,
    required this.alternateNo,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.type,
    required this.rent,
  });

  Widget buildRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
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
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.location_city, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hubName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            buildRow("Contact", contactPerson, Icons.person),
            buildRow("Address", address, Icons.location_on),
            buildRow("Pin", pin, Icons.pin_drop),
            buildRow("Phone", phone, Icons.phone),
            buildRow("Alternate", alternateNo, Icons.call),
            buildRow("Email", email, Icons.email),
            buildRow("Latitude", latitude, Icons.map),
            buildRow("Longitude", longitude, Icons.place),
            buildRow("Status", status, Icons.verified),
            buildRow("Type", type, Icons.business),
            buildRow("Rent / Month", rent, Icons.currency_rupee),

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