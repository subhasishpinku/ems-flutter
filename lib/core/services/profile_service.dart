import 'package:dio/dio.dart';
import 'package:ems/view/Home/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_client.dart';

class ProfileService {
  Future<ProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.get(
      "profile/index.php",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.data["status"] == "success") {
      return ProfileModel.fromJson(response.data["data"]["profile"]);
    }

    throw Exception(response.data["message"]);
  }

  //  Future<Response> updateProfile({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String password,
  //   required String dob,
  //   required String joiningDate,
  //   required String address,
  //   String? imagePath,
  // }) async {

  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token") ?? "";

  //   FormData formData = FormData.fromMap({
  //     "emp_name": name,
  //     "emp_email": email,
  //     "emp_phone": phone,
  //     "emp_password": password,
  //     "dob": dob,
  //     "date_of_join": joiningDate,
  //     "emp_address": address,

  //     if (imagePath != null)
  //       "profilepic": await MultipartFile.fromFile(
  //         imagePath,
  //       ),
  //   });

  //   final response = await ApiClient.dio.post(
  //     "profile/index.php",
  //     data: formData,
  //     options: Options(
  //       headers: {
  //         "Authorization": "Bearer $token",
  //       },
  //     ),
  //   );

  //   if (response.data["status"] == "success") {
  //     return response;
  //   }

  //   throw Exception(response.data["message"]);
  // }
  Future<Response> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dob,
    required String joiningDate,
    required String address,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    FormData formData = FormData.fromMap({
      "emp_name": name,
      "emp_email": email,
      "emp_phone": phone,
      "emp_password": password,
      "dob": dob,
      "date_of_join": joiningDate,
      "emp_address": address,

      // if (imagePath != null && imagePath.isNotEmpty)
      //   "profilepic": await MultipartFile.fromFile(
      //     imagePath,
      //     filename: imagePath.split("/").last,
      //   ),
      if (imagePath != null && imagePath.isNotEmpty)
        "profilepic": await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split("/").last,
          contentType: DioMediaType("image", "jpeg"),
        ),
//         "profilepic": await MultipartFile.fromFile(
//   imagePath,
//   filename: imagePath.split("/").last,
// ),
    });

    final response = await ApiClient.dio.post(
      "profile/index.php",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    print(response.data);

    if (response.data["status"] == "success") {
      return response;
    }

    throw Exception(response.data["message"] ?? "Profile update failed");
  }
}
