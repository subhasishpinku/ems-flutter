class ProblemModel {
  final String id;
  final String value;
  final String label;

  ProblemModel({
    required this.id,
    required this.value,
    required this.label,
  });

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['id'].toString(),
      value: json['value'].toString(),
      label: json['label'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'label': label,
    };
  }
}