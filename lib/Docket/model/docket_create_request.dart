class DocketCreateRequest {
  final String type;
  final String circuitId;
  final String requestBy;
  final String contactNo;
  final String problem;
  final String teamLeader;
  final String remarks;
  final String technician;

  DocketCreateRequest({
    required this.type,
    required this.circuitId,
    required this.requestBy,
    required this.contactNo,
    required this.problem,
    required this.teamLeader,
    required this.remarks,
    required this.technician,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "circuit_id": circuitId,
      "requestby": requestBy,
      "contactno": contactNo,
      "problem": problem,
      "teamleader": teamLeader,
      "remarks": remarks,
      "technician": technician,
    };
  }
}