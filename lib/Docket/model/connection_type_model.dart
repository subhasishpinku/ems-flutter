class ConnectionTypeModel {
  final String id;
  final String value;
  final String label;

  ConnectionTypeModel({
    required this.id,
    required this.value,
    required this.label,
  });

  factory ConnectionTypeModel.fromJson(Map<String, dynamic> json) {
    return ConnectionTypeModel(
      id: json['id'],
      value: json['value'],
      label: json['label'],
    );
  }
}