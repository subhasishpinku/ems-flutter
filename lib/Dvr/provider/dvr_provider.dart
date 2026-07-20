import 'package:ems/core/services/dvr_service.dart';
import 'package:flutter/material.dart';

class DvrProvider extends ChangeNotifier {
  final DvrService _service = DvrService();

  bool isLoading = false;

  List<dynamic> dvrList = [];

  Future<void> loadDvr({
    required String fromDate,
    required String toDate,
    String feedback = "",
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _service.getDvrList(
        fromDate: fromDate,
        toDate: toDate,
        feedback: feedback,
      );

      dvrList = response.data["data"]["items"];

      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
