class TeamLeaderModel {
  final String id;
  final String value;
  final String label;

  TeamLeaderModel({
    required this.id,
    required this.value,
    required this.label,
  });

  factory TeamLeaderModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaderModel(
      id: json["id"].toString(),
      value: json["value"].toString(),
      label: json["label"].toString(),
    );
  }
}