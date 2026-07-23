import 'package:ems/Docket/model/circuit_detail_model.dart';
import 'package:ems/Docket/model/connection_type_model.dart';
import 'package:ems/Docket/model/network_model.dart';
import 'package:ems/Docket/model/problem_model.dart';
import 'package:ems/Docket/model/team_leader_model.dart';
import 'package:ems/core/services/docket_service.dart';
import 'package:flutter/material.dart';

class DocketProvider extends ChangeNotifier {
  final DocketService _service = DocketService();
  List<ConnectionTypeModel> connectionTypes = [];
  String? selectedConnection;
  bool loading = false;

  List<NetworkModel> networks = [];

  String? selectedNetwork;
  List<ProblemModel> problems = [];
  String? selectedProblem;
  List<TeamLeaderModel> teamLeaders = [];
  String? selectedTeamLeader;
  String circuitId = "";
  CircuitDetailModel? circuitDetail;
  Future<void> loadConnectionTypes() async {
    connectionTypes = await _service.getConnectionTypes();

    print(connectionTypes.length);
    print(connectionTypes.map((e) => e.label).toList());

    notifyListeners();
  }

  Future<void> changeConnection(String? value) async {
    selectedConnection = value;
    notifyListeners();

    if (value != null) {
      await loadProblems();
      await loadCircuitId();
    }
  }

  Future<void> loadNetworks() async {
    loading = true;
    notifyListeners();

    try {
      networks = await _service.getNetworks();

      if (networks.isNotEmpty) {
        selectedNetwork = networks.first.value;
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadProblems() async {
    if (selectedConnection == null) return;

    problems = await _service.getProblems(
      connectionType: selectedConnection!,
      docType: "normal",
    );

    notifyListeners();
  }

  void changeProblem(String? value) {
    selectedProblem = value;
    notifyListeners();
  }

  Future<void> loadTeamLeaders() async {
    teamLeaders = await _service.getTeamLeaders();
    notifyListeners();
  }

  void changeTeamLeader(String? value) {
    selectedTeamLeader = value;
    notifyListeners();
  }

  Future<void> changeNetwork(String? value) async {
    selectedNetwork = value;
    notifyListeners();

    if (value != null) {
      await loadCircuitId();
    }
  }

  Future<void> loadCircuitId() async {
    if (selectedNetwork == null || selectedConnection == null) return;

    circuitId = await _service.getCircuitId(
      network: selectedNetwork!,
      connectionType: selectedConnection!,
    );

    await loadCircuitDetail();

    notifyListeners();
  }
  //   Future<void> loadCircuitId(TextEditingController controller) async {
  //   if (selectedNetwork == null || selectedConnection == null) return;

  //   final id = await _service.getCircuitId(
  //     network: selectedNetwork!,
  //     connectionType: selectedConnection!,
  //   );

  //   controller.text = id;
  // }
  Future<void> loadCircuitDetail() async {
    if (circuitId.isEmpty) return;

    circuitDetail = await _service.getCircuitDetail(circuitId);

    notifyListeners();
  }
}
