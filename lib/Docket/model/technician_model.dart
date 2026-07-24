class TechnicianModel {
  final String id;
  final String value;
  final String label;

  TechnicianModel({
    required this.id,
    required this.value,
    required this.label,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      id: json["id"].toString(),
      value: json["value"].toString(),
      label: json["label"].toString(),
    );
  }
}