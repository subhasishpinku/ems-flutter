class AttendanceModel {
  final int present;
  final int absent;
  final int lateIn;
  final int lateOut;

  AttendanceModel({
    required this.present,
    required this.absent,
    required this.lateIn,
    required this.lateOut,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      present: json["present"] ?? 0,
      absent: json["absent"] ?? 0,
      lateIn: json["late_in"] ?? 0,
      lateOut: json["late_out"] ?? 0,
    );
  }
}