class NetworkModel {
  final String value;
  final String label;

  NetworkModel({
    required this.value,
    required this.label,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      value: json['value'] ?? '',
      label: json['label'] ?? '',
    );
  }
}