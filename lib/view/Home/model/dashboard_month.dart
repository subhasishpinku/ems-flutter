class DashboardMonth {
  final int month;
  final int year;
  final String value;
  final String label;
  final bool selected;

  DashboardMonth({
    required this.month,
    required this.year,
    required this.value,
    required this.label,
    required this.selected,
  });

  factory DashboardMonth.fromJson(Map<String,dynamic> json){
    return DashboardMonth(
      month: json["month"],
      year: json["year"],
      value: json["value"],
      label: json["label"],
      selected: json["selected"],
    );
  }
}