import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../../view/Home/model/dashboard_month.dart';

class DashboardService {
  Future<List<DashboardMonth>> getMonths() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.dashboardMonths,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.data["status"] != "success") {
      throw Exception(response.data["message"]);
    }

    return (response.data["data"]["months"] as List)
        .map((e) => DashboardMonth.fromJson(e))
        .toList();
  }
}
