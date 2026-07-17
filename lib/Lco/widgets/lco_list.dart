import 'package:flutter/material.dart';
import 'lco_card.dart';

class LcoList extends StatelessWidget {
  const LcoList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        "networkName": "Manna Enterprise",
        "contactPerson": "Debkumar Manna",
        "address": "Andharmanik, West Bengal",
        "pincode": "743503",
        "phone": "9836862255",
        "alternateNo": "6289364699",
        "email": "abc@gmail.com",
        "latitude": "22.3701738",
        "longitude": "88.3555025",
        "type": "LCO",
        "hubOne": "Amtala_Hub",
        "hubTwo": "Baruipur_C/R",
        "fieldEngineer": "Prabir Das",
        "status": "Active",
      },
      {
        "networkName": "OM CABLE NET VISION",
        "contactPerson": "RAJDIP PRASAD",
        "address": "Kalikapur, Haltu",
        "pincode": "700078",
        "phone": "8101226002",
        "alternateNo": "8017147916",
        "email": "rajdip@gmail.com",
        "latitude": "22.5040871",
        "longitude": "88.3978355",
        "type": "LCO",
        "hubOne": "B L SAHA NOC",
        "hubTwo": "B L SAHA NOC",
        "fieldEngineer": "Jayanto Karmakar",
        "status": "Active",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final e = data[index];

        return LcoCard(
          networkName: e["networkName"]!,
          contactPerson: e["contactPerson"]!,
          address: e["address"]!,
          pincode: e["pincode"]!,
          phone: e["phone"]!,
          alternateNo: e["alternateNo"]!,
          email: e["email"]!,
          latitude: e["latitude"]!,
          longitude: e["longitude"]!,
          type: e["type"]!,
          hubOne: e["hubOne"]!,
          hubTwo: e["hubTwo"]!,
          fieldEngineer: e["fieldEngineer"]!,
          status: e["status"]!,
        );
      },
    );
  }
}