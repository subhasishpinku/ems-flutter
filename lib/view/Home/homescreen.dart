import 'package:ems/view/Home/widgets/attendance_card.dart';
import 'package:ems/view/Home/widgets/visit_report_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/home_provider.dart';
import 'widgets/home_card.dart';
import 'widgets/month_year_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const Scaffold(
        backgroundColor: Color(0xffF5F7FB),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeCard(),
                MonthYearCard(),
                AttendanceCard(),
                VisitReportCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
