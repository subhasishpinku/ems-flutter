class CircuitDetailModel {
  final String status;
  final String connectionType;
  final String connectionTypeId;
  final String hirerName;
  final String circuitId;
  final String locationA;
  final String mobileA;
  final String addressA;
  final String pinA;
  final String locationB;
  final String mobileB;
  final String addressB;
  final String pinB;
  final String customerName;
  final String customerContact;
  final String teamLeader;

  CircuitDetailModel({
    required this.status,
    required this.connectionType,
    required this.connectionTypeId,
    required this.hirerName,
    required this.circuitId,
    required this.locationA,
    required this.mobileA,
    required this.addressA,
    required this.pinA,
    required this.locationB,
    required this.mobileB,
    required this.addressB,
    required this.pinB,
    required this.customerName,
    required this.customerContact,
    required this.teamLeader,
  });

  factory CircuitDetailModel.fromJson(Map<String, dynamic> json) {
    return CircuitDetailModel(
      status: json["status"] ?? "",
      connectionType: json["connection_type"] ?? "",
      connectionTypeId: json["connection_type_id"] ?? "",
      hirerName: json["hirer_name"] ?? "",
      circuitId: json["circuit_id"] ?? "",
      locationA: json["locationA"] ?? "",
      mobileA: json["mobileA"] ?? "",
      addressA: json["addressA"] ?? "",
      pinA: json["pinA"] ?? "",
      locationB: json["locationB"] ?? "",
      mobileB: json["mobileB"] ?? "",
      addressB: json["addressB"] ?? "",
      pinB: json["pinB"] ?? "",
      customerName: json["customer_name"] ?? "",
      customerContact: json["customer_contact"] ?? "",
      teamLeader: json["teamleader"] ?? "",
    );
  }
}
