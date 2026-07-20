import 'package:dio/dio.dart';
import 'package:ems/LeaveApplication/model/leave_model.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/LeaveApplication/model/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveService {
  Future<List<Employee>> getEmployees() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "leave/employees.php",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.data["status"] == "success") {
      List list = response.data["data"]["employees"];

      return list.map((e) => Employee.fromJson(e)).toList();
    }

    throw Exception(response.data["message"]);
  }

  // Future<List<LeaveModel>> getLeaveList({
  //   String? status,
  //   String? fromDate,
  //   String? toDate,
  //   int? employeeId,
  // }) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token") ?? "";

  //   final Map<String, dynamic> query = {"page": 1, "per_page": 20};

  //   if (fromDate != null && fromDate.isNotEmpty) {
  //     query["from_date"] = fromDate;
  //   }

  //   if (toDate != null && toDate.isNotEmpty) {
  //     query["to_date"] = toDate;
  //   }

  //   if (status != null && status.isNotEmpty) {
  //     query["status"] = status;
  //   }

  //   if (employeeId != null) {
  //     query["employee_id"] = employeeId;
  //   }

  //   final response = await ApiClient.dio.get(
  //     "leave/list.php",
  //     queryParameters: query,
  //     options: Options(headers: {"Authorization": "Bearer $token"}),
  //   );

  //   List list = response.data["data"]["leaves"] ?? [];

  //   return list.map((e) => LeaveModel.fromJson(e)).toList();
  // }

  Future<List<LeaveModel>> getLeaveList({
    required String status,
    required String fromDate,
    required String toDate,
    required int employeeId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "leave/list.php",

      queryParameters: {
        "page": 1,

        "per_page": 20,

        "status": status,

        "from_date": fromDate,

        "to_date": toDate,

        "employee_id": employeeId,
      },

      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    List list = response.data["data"]["leaves"];

    return list.map((e) => LeaveModel.fromJson(e)).toList();
  }

  Future<Response> applyLeave({
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    return await ApiClient.dio.post(
      "leave/create.php",
      data: {
        "leave_type": leaveType,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
