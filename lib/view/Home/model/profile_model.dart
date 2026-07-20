class ProfileModel {
  final String empName;
  final String email;
  final String phone;
  final String dob;
  final String joiningDate;
  final String address;
  final String profileImage;
  final String password; // Add this

  ProfileModel({
    required this.empName,
    required this.email,
    required this.phone,
    required this.dob,
    required this.joiningDate,
    required this.address,
    required this.profileImage,
    required this.password,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      empName: json["emp_name"] ?? "",
      email: json["emp_email"] ?? "",
      phone: json["emp_phone"] ?? "",
      dob: json["dob"] ?? "",
      joiningDate: json["date_of_join"] ?? "",
      address: json["emp_address"] ?? "",
      profileImage: json["profile"] ?? "",
      password: json["emp_password"] ?? "", // <-- এটা অবশ্যই থাকতে হবে
    );
  }
}
