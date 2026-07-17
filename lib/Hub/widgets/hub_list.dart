import 'package:flutter/material.dart';
import 'hub_card.dart';

class HubList extends StatelessWidget {
  const HubList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hubs = [
      {
        "hubName": "Neha Cable Madhyamgram C/R",
        "contactPerson": "Sanjib Das",
        "address": "Jugberia North 24 Pgs 700110",
        "pin": "700110",
        "phone": "7980481319",
        "alternateNo": "0",
        "email": "dassanjib186@gmail.com",
        "latitude": "",
        "longitude": "",
        "status": "Active",
        "type": "Hub",
        "rentPerMonth": ".00",
      },
      {
        "hubName": "STT DATA CENTRE (Ultadanga)",
        "contactPerson": "STT",
        "address": "Ultadanga",
        "pin": "700025",
        "phone": "08981767292",
        "alternateNo": "00",
        "email": "bacbpl@bacbpl.in",
        "latitude": "",
        "longitude": "",
        "status": "Active",
        "type": "Hub",
        "rentPerMonth": ".00",
      },
      {
        "hubName": "STAR SKY VISION",
        "contactPerson": "BARNAD DAS",
        "address": "356/4 M.G Road, Kolkata",
        "pin": "700104",
        "phone": "9836801566",
        "alternateNo": "69041400",
        "email": "starskyvision.barnad@gmail.com",
        "latitude": "",
        "longitude": "",
        "status": "Active",
        "type": "Hub",
        "rentPerMonth": ".00",
      },
      {
        "hubName": "WRONG",
        "contactPerson": "SANJEEB NANDI",
        "address": "125 S N Roy Road, Kolkata 700038",
        "pin": "700038",
        "phone": "9804362744",
        "alternateNo": "69041400",
        "email": "san1968jb@gmail.com",
        "latitude": "22.506667",
        "longitude": "88.325556",
        "status": "Inactive",
        "type": "Hub",
        "rentPerMonth": ".00",
      },
    ];

    return ListView.builder(
      itemCount: hubs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final hub = hubs[index];

        return HubCard(
          hubName: hub["hubName"] ?? "",
          contactPerson: hub["contactPerson"] ?? "",
          address: hub["address"] ?? "",
          pin: hub["pin"] ?? "",
          phone: hub["phone"] ?? "",
          alternateNo: hub["alternateNo"] ?? "",
          email: hub["email"] ?? "",
          latitude: hub["latitude"] ?? "",
          longitude: hub["longitude"] ?? "",
          status: hub["status"] ?? "",
          type: hub["type"] ?? "",
          rent: hub["rentPerMonth"] ?? "",
        );
      },
    );
  }
}
