import 'package:dio/dio.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/core/network/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DvrService {
  Future<Response> getDvrList({
    required String fromDate,
    required String toDate,
    String feedback = "",
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      ApiEndpoints.dvrList,
      queryParameters: {
        "from_date": fromDate,
        "to_date": toDate,
        "feedback": feedback,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.data["status"] == "success") {
      return response;
    }

    throw Exception(response.data["message"]);
  }

    // ========================================
  // Helper: Get token from SharedPreferences
  // ========================================
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  // ========================================
  // Helper: Headers with Bearer token
  // ========================================
  Future<Options> _getAuthOptions() async {
    final token = await _getToken();
    return Options(
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
  }

  // ========================================
  // 1. OTP Flow
  // ========================================

  /// Send OTP to mobile number
  Future<Response> sendOTP({
    required String phoneNo,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrOtp,
        data: {
          "action": "send",
          "phone_no": phoneNo,
        },
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Verify OTP
  Future<Response> verifyOTP({
    required String phoneNo,
    required String otp,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrOtp,
        data: {
          "action": "verify",
          "phone_no": phoneNo,
          "otp": otp,
        },
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 2. Metadata Endpoints
  // ========================================

  /// Get call types
  Future<Response> getCallTypes() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=call_types",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get visit types
  Future<Response> getVisitTypes() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=visit_types",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get locations by visit type
  Future<Response> getLocations({
    required String visitTypeId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=locations&visit_type_id=$visitTypeId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get companies
  Future<Response> getCompanies() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=companies",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get leads
  Future<Response> getLeads() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=leads",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get document types
  Future<Response> getDocumentTypes() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=document_types",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get problems
  Future<Response> getProblems() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=problems",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get departments
  Future<Response> getDepartments() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=departments",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get employees by department
  Future<Response> getEmployees({
    required String department,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrMetadata}?action=employees&department=$department",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 3. Details Endpoints
  // ========================================

  /// Get lead details
  Future<Response> getLeadDetails({
    required String leadId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrLeadDetails}?lead_id=$leadId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get company details
  Future<Response> getCompanyDetails({
    required String companyId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrCompanyDetails}?company_id=$companyId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 4. Create DVR
  // ========================================

  /// Create DVR with JSON data
  Future<Response> createDVR({
    required Map<String, dynamic> data,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrCreate,
        data: data,
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Create DVR with file upload (multipart/form-data)
  Future<Response> createDVRWithFiles({
    required Map<String, dynamic> data,
    required List<MultipartFile> files,
  }) async {
    try {
      final token = await _getToken();
      final formData = FormData.fromMap({
        ...data,
        if (files.isNotEmpty) "documents[]": files,
      });

      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrCreate,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 5. DVR List/Report
  // ========================================

  /// Get DVR list with filters
  Future<Response> getDVRList({
    String? fromDate,
    String? toDate,
    int? daterange,
    String? department,
    String? employee,
    String? feedback,
    int? page,
    int? perPage,
  }) async {
    try {
      final options = await _getAuthOptions();
      final queryParams = <String, dynamic>{};

      if (fromDate != null && fromDate.isNotEmpty) {
        queryParams["from_date"] = fromDate;
      }
      if (toDate != null && toDate.isNotEmpty) {
        queryParams["to_date"] = toDate;
      }
      if (daterange != null) {
        queryParams["daterange"] = daterange;
      }
      if (department != null && department.isNotEmpty) {
        queryParams["department"] = department;
      }
      if (employee != null && employee.isNotEmpty) {
        queryParams["employee"] = employee;
      }
      if (feedback != null && feedback.isNotEmpty) {
        queryParams["feedback"] = feedback;
      }
      if (page != null) {
        queryParams["page"] = page;
      }
      if (perPage != null) {
        queryParams["per_page"] = perPage;
      }

      final response = await ApiClient.dio.get(
        ApiEndpoints.dvrList,
        queryParameters: queryParams,
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Get DVR list with feedback filter (simplified)
  Future<Response> getDVRListByFeedback({
    required String fromDate,
    required String toDate,
    String feedback = "",
  }) async {
    return await getDVRList(
      fromDate: fromDate,
      toDate: toDate,
      feedback: feedback,
    );
  }

  // ========================================
  // 6. Confirm DVR List
  // ========================================

  /// Get today's unconfirmed DVRs
  Future<Response> getConfirmList({
    int? page,
    int? perPage,
  }) async {
    try {
      final options = await _getAuthOptions();
      final queryParams = <String, dynamic>{};

      if (page != null) {
        queryParams["page"] = page;
      }
      if (perPage != null) {
        queryParams["per_page"] = perPage;
      }

      final response = await ApiClient.dio.get(
        ApiEndpoints.dvrConfirmList,
        queryParameters: queryParams,
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 7. Show DVR
  // ========================================

  /// Get single DVR details
  Future<Response> getDVRDetails({
    required String dvrId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrShow}?dvr_id=$dvrId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 8. Update DVR
  // ========================================

  /// Update DVR feedback/details
  Future<Response> updateDVR({
    required Map<String, dynamic> data,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrUpdate,
        data: data,
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Update DVR feedback only
  Future<Response> updateDVRFeedback({
    required String dvrId,
    required String feedback,
    String? remarks,
  }) async {
    final data = {
      "dvr_id": dvrId,
      "feedback": feedback,
      if (remarks != null) "remarks": remarks,
    };
    return await updateDVR(data: data);
  }

  /// Update DVR with problems
  Future<Response> updateDVRWithProblems({
    required String dvrId,
    required String feedback,
    required List<String> problemIds,
    String? remarks,
  }) async {
    final data = {
      "dvr_id": dvrId,
      "feedback": feedback,
      "problem_ids": problemIds,
      if (remarks != null) "remarks": remarks,
    };
    return await updateDVR(data: data);
  }

  // ========================================
  // 9. Confirm DVR
  // ========================================

  /// Confirm a single DVR
  Future<Response> confirmDVR({
    required String dvrId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrConfirm,
        data: {
          "action": "one",
          "dvr_id": dvrId,
        },
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Confirm all DVRs assigned to current user for today
  Future<Response> confirmAllDVRs() async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrConfirm,
        data: {
          "action": "all",
        },
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // 10. Documents Endpoints
  // ========================================

  /// List documents for a DVR
  Future<Response> getDocuments({
    required String dvrId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.get(
        "${ApiEndpoints.dvrDocuments}?dvr_id=$dvrId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Upload document(s) for a DVR
  Future<Response> uploadDocuments({
    required String dvrId,
    required List<MultipartFile> files,
    List<Map<String, String>>? documentMeta,
  }) async {
    try {
      final token = await _getToken();
      final formData = FormData();

      // Add dvr_id
      formData.fields.add(MapEntry("dvr_id", dvrId));

      // Add document metadata if provided
      if (documentMeta != null) {
        for (int i = 0; i < documentMeta.length; i++) {
          final meta = documentMeta[i];
          if (meta.containsKey("doc_type")) {
            formData.fields.add(
              MapEntry("documents[$i][doc_type]", meta["doc_type"]!),
            );
          }
          if (meta.containsKey("description")) {
            formData.fields.add(
              MapEntry("documents[$i][description]", meta["description"]!),
            );
          }
        }
      }

      // Add files
      for (final file in files) {
        formData.files.add(MapEntry("documents[]", file));
      }

      final response = await ApiClient.dio.post(
        ApiEndpoints.dvrDocuments,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  /// Upload a single document
  Future<Response> uploadDocument({
    required String dvrId,
    required MultipartFile file,
    String? docType,
    String? description,
  }) async {
    final documentMeta = docType != null || description != null
        ? [
            {
              if (docType != null) "doc_type": docType,
              if (description != null) "description": description,
            },
          ]
        : null;

    return await uploadDocuments(
      dvrId: dvrId,
      files: [file],
      documentMeta: documentMeta,
    );
  }

  /// Delete a document
  Future<Response> deleteDocument({
    required int documentId,
  }) async {
    try {
      final options = await _getAuthOptions();
      final response = await ApiClient.dio.delete(
        "${ApiEndpoints.dvrDocuments}?id=$documentId",
        options: options,
      );

      if (response.data["status"] == "success") {
        return response;
      }
      throw Exception(response.data["message"]);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // ========================================
  // Error Handler
  // ========================================

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data != null && data is Map<String, dynamic>) {
        return data["message"] ?? data["error"] ?? "Server error occurred";
      }
      return "Server error: ${e.response?.statusCode}";
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please check your internet connection.";
      case DioExceptionType.receiveTimeout:
        return "Server not responding. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Request timeout. Please try again.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network.";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}