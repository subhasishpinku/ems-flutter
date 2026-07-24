import 'package:dio/dio.dart';
import 'package:ems/Docket/model/circuit_detail_model.dart';
import 'package:ems/Docket/model/connection_type_model.dart';
import 'package:ems/Docket/model/docket_create_request.dart';
import 'package:ems/Docket/model/network_model.dart';
import 'package:ems/Docket/model/problem_model.dart';
import 'package:ems/Docket/model/team_leader_model.dart';
import 'package:ems/Docket/model/technician_model.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/core/network/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocketService {
  Future<List<NetworkModel>> getNetworks() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.docketNetworks,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return (response.data["data"]["items"] as List)
          .map((e) => NetworkModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<ConnectionTypeModel>> getConnectionTypes() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.docketMetadata,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200 && response.data["status"] == "success") {
      return (response.data["data"]["items"] as List)
          .map((e) => ConnectionTypeModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<ProblemModel>> getProblems({
    required String connectionType,
    required String docType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "docket/metadata.php",
      queryParameters: {
        "action": "problems",
        "connection_type": connectionType,
        "doctype": docType,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return (response.data["data"]["items"] as List)
          .map((e) => ProblemModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<TeamLeaderModel>> getTeamLeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.docketTeamLeaders,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return (response.data["data"]["items"] as List)
          .map((e) => TeamLeaderModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<String> getCircuitId({
    required String network,
    required String connectionType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "docket/metadata.php",
      queryParameters: {
        "action": "circuit",
        "network": network,
        "connection_type": connectionType,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return response.data["data"]["circuit_id"] ?? "";
    }

    return "";
  }

  Future<CircuitDetailModel?> getCircuitDetail(String circuitId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "docket/metadata.php",
      queryParameters: {"action": "circuit_detail", "circuit_id": circuitId},
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return CircuitDetailModel.fromJson(response.data["data"]["circuit"]);
    }

    return null;
  }

  Future<List<TechnicianModel>> getTechnicians() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.docketTechnicians,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      return (response.data["data"]["items"] as List)
          .map((e) => TechnicianModel.fromJson(e))
          .toList();
    }

    return [];
  }
Future<Map<String, dynamic>> createDocket({
  required String type,
  required String circuitId,
  required String requestBy,
  required String contactNo,
  required String problem,
  required String teamLeader,
  required String remarks,
  required String technician,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token") ?? "";

  try {
    final response = await ApiClient.dio.post(
      ApiEndpoints.docketCreate,
      data: {
        "type": type,
        "circuit_id": circuitId,
        "requestby": requestBy,
        "contactno": contactNo,
        "problem": problem,
        "teamleader": teamLeader,
        "remarks": remarks,
        "technician": technician,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response!.data;
    }

    return {
      "status": "error",
      "message": "Network Error",
    };
  }}
}
