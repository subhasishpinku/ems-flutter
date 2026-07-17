class LeaveModel {
  final int id;
  final String employee;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String reason;
  final String status;
  final String applyDate;

  LeaveModel({
    required this.id,
    required this.employee,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
    required this.applyDate,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json["id"] ?? 0,
      employee: json["employee"]?["emp_name"] ?? "",
      leaveType: json["leave_type"] ?? "",
      fromDate: json["from_date"] ?? "",
      toDate: json["to_date"] ?? "",
      reason: json["reason"] ?? "",
      status: json["status"] ?? "",
      applyDate: json["apply_date"] ?? "",
    );
  }
}
