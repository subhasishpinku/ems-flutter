class Employee {
  final int empNo;
  final String empId;
  final String empName;
  final String companyId;

  Employee({
    required this.empNo,
    required this.empId,
    required this.empName,
    required this.companyId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empNo: json["emp_no"],
      empId: json["emp_id"],
      empName: json["emp_name"],
      companyId: json["company_id"].toString(),
    );
  }
}