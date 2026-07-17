import 'package:ems/LeaveApplication/model/employee_model.dart';
import 'package:ems/LeaveApplication/model/leave_model.dart';
import 'package:ems/core/services/leave_service.dart';
import 'package:flutter/material.dart';

class LeaveProvider extends ChangeNotifier {
  final LeaveService _service = LeaveService();

  List<Employee> employees = [];

  bool isLoading = false;

  // String? selectedEmployee;
  Employee? selectedEmployee;
  List<LeaveModel> leaveList = [];

  bool isSearching = false;
  Future<void> loadEmployees() async {
    try {
      isLoading = true;
      notifyListeners();

      employees = await _service.getEmployees();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectEmployee(String? value) {
    if (value == null) return;

    selectedEmployee = employees.firstWhere((e) => e.empName == value);

    notifyListeners();
  }

  Future<void> searchLeave({
    required String status,
    required String fromDate,
    required String toDate,
  }) async {
    if (selectedEmployee == null) {
      throw Exception("Please select an employee");
    }

    try {
      isSearching = true;
      notifyListeners();

      leaveList = await _service.getLeaveList(
        status: status,
        fromDate: fromDate,
        toDate: toDate,
        employeeId: selectedEmployee!.empNo,
      );
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }
}
