class VisitSummaryModel {
  final int totalVisits;
  final int positiveResponse;
  final String avgTimeSpend;
  final String totalWorkingHour;
  final String totalVisit;
  final String idleTime;

  VisitSummaryModel({
    required this.totalVisits,
    required this.positiveResponse,
    required this.avgTimeSpend,
    required this.totalWorkingHour,
    required this.totalVisit,
    required this.idleTime,
  });

  factory VisitSummaryModel.fromJson(Map<String, dynamic> json) {
    return VisitSummaryModel(
      totalVisits: json["total_visits"] ?? 0,
      positiveResponse: json["positive_response"] ?? 0,
      avgTimeSpend: json["avg_time_spend"] ?? "00:00",
      totalWorkingHour: json["total_working_hour"] ?? "00:00",
      totalVisit: json["total_visit"] ?? "00:00",
      idleTime: json["idle_time"] ?? "00:00",
    );
  }
}