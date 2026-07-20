// field_sheet_create.dart
import 'package:ems/FieldSheet/widgets/FeedbackCard.dart';
import 'package:ems/FieldSheet/widgets/GpsRetryCard.dart';
import 'package:ems/FieldSheet/widgets/InTimeCard.dart';
import 'package:ems/FieldSheet/widgets/MobileOtpCard.dart';
import 'package:ems/FieldSheet/widgets/OtpVerificationCard.dart';
import 'package:ems/FieldSheet/widgets/ProblemSelectionCard.dart';
import 'package:ems/FieldSheet/widgets/RemarksCard.dart';
import 'package:ems/FieldSheet/widgets/UploadMoreCard.dart';
import 'package:ems/FieldSheet/widgets/UploadOptionCard.dart';
import 'package:ems/core/services/dvr_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

// Enum for all steps
enum FieldSheetStep {
  callType,
  visitType,
  visitLocation,
  lead,
  customerInterest,
  customerName,
  customerMobile,
  customerEmail,
  hub,
  customerAddress,
  createLeadSuccess,
  lcoName,
  leadDetails,
  problem,
  inTime,
  feedback,
  remarks,
  uploadChoice,
  uploadDocument,
  uploadMore,
  otpMobile,
  otp,
  gps,
  completed,
}

class Fieldsheetcreate extends StatefulWidget {
  const Fieldsheetcreate({super.key});

  @override
  State<Fieldsheetcreate> createState() => _FieldsheetcreateState();
}

class _FieldsheetcreateState extends State<Fieldsheetcreate> {
  // Services
  final DvrService _dvrService = DvrService();

  // Form fields
  String? callType;
  String? visitType;
  String? locationType;
  String? lead;
  String? customerInterest;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? hub;
  String? customerAddress;
  String? lcoName;
  String? selectedProblem;
  TimeOfDay? selectedTime;
  String? selectedFeedback;
  String? uploadOption;
  String? uploadMoreOption;
  String? gpsOption;

  // Documents
  List<File> documents = [];

  // Mobile & OTP
  String? mobileNumber;
  String? otp;
  bool isOtpVerified = false;
  bool isGpsChecked = false;
  bool isLoading = false;

  // GPS Location (simulated - in real app, get from device GPS)
  String meetingLatitude = "22.572645";
  String meetingLongitude = "88.363892";
  String meetingAddress = "Kolkata, West Bengal, India";

  // DVR Response
  String? createdDvrId;
  String? createdDvrIdEncoded;

  // Step management
  FieldSheetStep currentStep = FieldSheetStep.callType;

  // Data from API
  List<Map<String, dynamic>> callTypes = [];
  List<Map<String, dynamic>> visitTypes = [];
  List<Map<String, dynamic>> locations = [];
  List<Map<String, dynamic>> companies = [];
  List<Map<String, dynamic>> leads = [];
  List<Map<String, dynamic>> problems = [];
  List<Map<String, dynamic>> feedbacks = [];

  final List<String> leadList = [
    "1564161586",
    "Alpha IT (9433253566)",
    "Amit Ghosh (+919903042565)",
    "AP3 Cable Network",
    "Arijit Dutta Bakshi",
  ];

  final List<String> problemList = [
    "Existing Corporate Visit",
    "Existing LCO Visit",
    "Network Related",
    "New Corporate Visit",
    "New LCO Visit",
  ];

  final List<String> feedbackList = [
    "Pending",
    "Solve",
    "Negative",
    "Reschedule Call/Visit",
    "Positive for Feasibility",
  ];

  final List<String> interestList = ["Broadband", "Cable", "Both"];

  @override
  void initState() {
    super.initState();
    _loadMetadata();
  }

  // ========================================
  // API Methods
  // ========================================

  Future<void> _loadMetadata() async {
    try {
      setState(() => isLoading = true);

      // Load all metadata in parallel
      final results = await Future.wait([
        _dvrService.getCallTypes(),
        _dvrService.getVisitTypes(),
        _dvrService.getProblems(),
        _dvrService.getLeads(),
      ]);

      // Process call types
      if (results[0].data['status'] == 'success') {
        final items = results[0].data['data']['items'] as List?;
        if (items != null) {
          setState(() {
            callTypes = items.map((e) => e as Map<String, dynamic>).toList();
          });
        }
      }

      // Process visit types
      if (results[1].data['status'] == 'success') {
        final items = results[1].data['data']['items'] as List?;
        if (items != null) {
          setState(() {
            visitTypes = items.map((e) => e as Map<String, dynamic>).toList();
          });
        }
      }

      // Process problems
      if (results[2].data['status'] == 'success') {
        final items = results[2].data['data']['items'] as List?;
        if (items != null) {
          setState(() {
            problems = items.map((e) => e as Map<String, dynamic>).toList();
          });
        }
      }

      // Process leads
      if (results[3].data['status'] == 'success') {
        final items = results[3].data['data']['items'] as List?;
        if (items != null) {
          setState(() {
            leads = items.map((e) => e as Map<String, dynamic>).toList();
          });
        }
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Error loading metadata: $e");
    }
  }

  Future<void> _sendOTP(String phone) async {
    try {
      setState(() => isLoading = true);
      final response = await _dvrService.sendOTP(phoneNo: phone);

      if (response.data['status'] == 'success') {
        setState(() {
          mobileNumber = phone;
          currentStep = FieldSheetStep.otp;
          isLoading = false;
        });
        _showSnackBar("OTP sent successfully to $phone");
      } else {
        setState(() => isLoading = false);
        _showSnackBar(response.data['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Error sending OTP: $e");
    }
  }

  Future<void> _verifyOTP(String otpCode) async {
    try {
      setState(() => isLoading = true);
      final response = await _dvrService.verifyOTP(
        phoneNo: mobileNumber!,
        otp: otpCode,
      );

      if (response.data['status'] == 'success') {
        setState(() {
          otp = otpCode;
          isOtpVerified = true;
          currentStep = FieldSheetStep.gps;
          isLoading = false;
        });
        _showSnackBar("OTP Verified Successfully!");
      } else {
        setState(() => isLoading = false);
        _showSnackBar(response.data['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Error verifying OTP: $e");
    }
  }

  Future<void> _resendOTP() async {
    if (mobileNumber != null) {
      await _sendOTP(mobileNumber!);
    }
  }

  Future<void> _submitDVR() async {
    try {
      setState(() => isLoading = true);

      // Build DVR data
      final Map<String, dynamic> data = {
        'visit_type': _getEncodedId(visitTypes, visitType),
        'in_time': selectedTime?.format(context) ?? '',
        'feedback': selectedFeedback ?? '',
        'otp_phone_no': mobileNumber ?? '',
        'meeting_latitude': meetingLatitude,
        'meeting_longitude': meetingLongitude,
        'meeting_address': meetingAddress,
      };

      // Optional fields
      if (callType != null) {
        data['call_type'] = _getEncodedId(callTypes, callType);
      }

      if (selectedProblem != null) {
        final problemId = _getEncodedId(problems, selectedProblem);
        if (problemId != null) {
          data['problem_ids'] = [problemId];
        }
      }

      // Visit type specific
      if (visitType == "Existing") {
        if (locationType != null) {
          data['location_id'] = _getEncodedId(locations, locationType);
        }
        if (lead != null) {
          data['company_id'] = _getEncodedId(leads, lead);
        }
      } else if (visitType == "New") {
        if (lead != null) {
          data['lead_id'] = _getEncodedId(leads, lead);
        }
        if (lcoName != null && lcoName!.isNotEmpty) {
          data['lco_name'] = lcoName;
        }
      }

      // Remarks
      if (customerName != null && customerName!.isNotEmpty) {
        data['remarks'] = customerName;
      }

      // Call API
      final response = await _dvrService.createDVR(data: data);

      if (response.data['status'] == 'success') {
        final dvrData = response.data['data'];
        setState(() {
          createdDvrId = dvrData['dvr_id']?.toString();
          createdDvrIdEncoded = dvrData['dvr_id_encoded'];
          isLoading = false;
        });

        // Upload documents if any
        if (documents.isNotEmpty && createdDvrIdEncoded != null) {
          await _uploadDocuments(createdDvrIdEncoded!);
        }

        // Move to completed step
        setState(() {
          currentStep = FieldSheetStep.completed;
        });
        _showSnackBar("DVR submitted successfully!");
      } else {
        setState(() => isLoading = false);
        _showSnackBar(response.data['message'] ?? 'Failed to create DVR');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Error submitting DVR: $e");
    }
  }

  Future<void> _uploadDocuments(String dvrId) async {
    try {
      final List<MultipartFile> files = [];

      for (final file in documents) {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
        files.add(multipartFile);
      }

      final response = await _dvrService.uploadDocuments(
        dvrId: dvrId,
        files: files,
        documentMeta: [
          {
            'doc_type': 'MQ==', // Base64 encoded document type ID
            'description': 'Field Sheet Document',
          }
        ],
      );

      if (response.data['status'] != 'success') {
        _showSnackBar("Warning: Documents uploaded with errors");
      }
    } catch (e) {
      _showSnackBar("Error uploading documents: $e");
    }
  }

  String? _getEncodedId(List<Map<String, dynamic>> items, String? label) {
    if (label == null) return null;
    final item = items.firstWhere(
      (e) => e['label'] == label || e['value'] == label,
      orElse: () => {},
    );
    return item['value'] ?? item['id']?.toString();
  }

  // ========================================
  // Widget Build Methods
  // ========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Sheet Creation'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 20),
            _buildCurrentStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = FieldSheetStep.values;
    final currentIndex = steps.indexOf(currentStep);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length - 1, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 15,
          height: 4,
          decoration: BoxDecoration(
            color: index <= currentIndex ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case FieldSheetStep.callType:
        return _buildCallTypeStep();
      case FieldSheetStep.visitType:
        return _buildVisitTypeStep();
      case FieldSheetStep.visitLocation:
        return _buildVisitLocationStep();
      case FieldSheetStep.lead:
        return _buildLeadStep();
      case FieldSheetStep.customerInterest:
        return _buildCustomerInterestStep();
      case FieldSheetStep.customerName:
        return _buildCustomerNameStep();
      case FieldSheetStep.customerMobile:
        return _buildCustomerMobileStep();
      case FieldSheetStep.customerEmail:
        return _buildCustomerEmailStep();
      case FieldSheetStep.hub:
        return _buildHubStep();
      case FieldSheetStep.customerAddress:
        return _buildCustomerAddressStep();
      case FieldSheetStep.createLeadSuccess:
        return _buildLeadSuccessStep();
      case FieldSheetStep.lcoName:
        return _buildLcoNameStep();
      case FieldSheetStep.leadDetails:
        return _buildLeadDetailsStep();
      case FieldSheetStep.problem:
        return _buildProblemSelectionStep();
      case FieldSheetStep.inTime:
        return _buildInTimeStep();
      case FieldSheetStep.feedback:
        return _buildFeedbackStep();
      case FieldSheetStep.remarks:
        return _buildRemarksStep();
      case FieldSheetStep.uploadChoice:
        return _buildUploadChoiceStep();
      case FieldSheetStep.uploadDocument:
        return _buildUploadDocumentsStep();
      case FieldSheetStep.uploadMore:
        return _buildUploadMoreStep();
      case FieldSheetStep.otpMobile:
        return _buildMobileOtpStep();
      case FieldSheetStep.otp:
        return _buildOtpVerificationStep();
      case FieldSheetStep.gps:
        return _buildGpsStep();
      case FieldSheetStep.completed:
        return _buildCompletedStep();
      default:
        return const SizedBox();
    }
  }

  // STEP 0: Call Type
  Widget _buildCallTypeStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Call Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: callType,
              decoration: InputDecoration(
                labelText: "Call Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: callTypes.isEmpty
                  ? const [
                      DropdownMenuItem<String>(
                        value: "Indoor",
                        child: Text("Indoor"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Outdoor",
                        child: Text("Outdoor"),
                      ),
                    ]
                  : callTypes
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e['label'],
                          child: Text(e['label']),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => callType = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (callType != null) {
                        setState(() => currentStep = FieldSheetStep.visitType);
                      } else {
                        _showSnackBar("Please select call type");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 1: Visit Type
  Widget _buildVisitTypeStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Visit Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: visitType,
              decoration: InputDecoration(
                labelText: "Visit Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: visitTypes.isEmpty
                  ? const [
                      DropdownMenuItem<String>(
                        value: "New",
                        child: Text("New"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Existing",
                        child: Text("Existing"),
                      ),
                    ]
                  : visitTypes
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e['label'],
                          child: Text(e['label']),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => visitType = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.callType),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (visitType != null) {
                        setState(
                          () => currentStep = FieldSheetStep.visitLocation,
                        );
                      } else {
                        _showSnackBar("Please select visit type");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 2: Visit Location
  Widget _buildVisitLocationStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Visit Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: locationType,
              decoration: InputDecoration(
                labelText: "Visit Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: "Corporate",
                  child: Text("Corporate"),
                ),
                DropdownMenuItem<String>(
                  value: "LCO",
                  child: Text("LCO"),
                ),
              ],
              onChanged: (value) => setState(() => locationType = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.visitType),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (locationType != null) {
                        setState(() => currentStep = FieldSheetStep.lead);
                      } else {
                        _showSnackBar("Please select visit location");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 3: Lead Selection
  Widget _buildLeadStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Lead",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: lead,
              decoration: InputDecoration(
                labelText: "Lead",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: leads.isEmpty
                  ? leadList
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList()
                  : leads
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                          value: e['label'],
                          child: Text(e['label']),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => lead = value),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() => currentStep = FieldSheetStep.customerInterest);
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Create New Lead",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.visitLocation,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (lead != null) {
                        setState(() => currentStep = FieldSheetStep.lcoName);
                      } else {
                        _showSnackBar("Please select a lead or create new");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 4: Customer Interest
  Widget _buildCustomerInterestStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What are customer interested in?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: customerInterest,
              decoration: InputDecoration(
                hintText: "Select interest...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: interestList
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => customerInterest = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.lead),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (customerInterest != null) {
                        setState(
                          () => currentStep = FieldSheetStep.customerName,
                        );
                      } else {
                        _showSnackBar("Please select customer interest");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 5: Customer Name
  Widget _buildCustomerNameStep() {
    final controller = TextEditingController(text: customerName);

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter customer name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => customerName = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.customerInterest,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (customerName != null && customerName!.isNotEmpty) {
                        setState(
                          () => currentStep = FieldSheetStep.customerMobile,
                        );
                      } else {
                        _showSnackBar("Please enter customer name");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 6: Customer Mobile
  Widget _buildCustomerMobileStep() {
    final controller = TextEditingController(text: customerMobile);

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Mobile",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                counterText: "",
                hintText: "Enter mobile number...",
                prefixIcon: const Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => customerMobile = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.customerName,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (customerMobile != null &&
                          customerMobile!.length == 10) {
                        setState(
                          () => currentStep = FieldSheetStep.customerEmail,
                        );
                      } else {
                        _showSnackBar(
                          "Please enter valid 10 digit mobile number",
                        );
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 7: Customer Email
  Widget _buildCustomerEmailStep() {
    final controller = TextEditingController(text: customerEmail);

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter email address...",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => customerEmail = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.customerMobile,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => currentStep = FieldSheetStep.hub);
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 8: Hub
  Widget _buildHubStep() {
    final List<String> hubList = ["Adrit_C/R", "Hub_1", "Hub_2", "Hub_3"];

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Hub",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: hub,
              decoration: InputDecoration(
                hintText: "Search hub...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: hubList
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => hub = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.customerEmail,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (hub != null) {
                        setState(
                          () => currentStep = FieldSheetStep.customerAddress,
                        );
                      } else {
                        _showSnackBar("Please select hub");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 9: Customer Address
  Widget _buildCustomerAddressStep() {
    final controller = TextEditingController(text: customerAddress);

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter full address...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => customerAddress = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.hub),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (customerAddress != null &&
                          customerAddress!.isNotEmpty) {
                        _showLeadSuccessDialog();
                      } else {
                        _showSnackBar("Please enter customer address");
                      }
                    },
                    child: const Text("Submit Lead"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 10: Lead Created Successfully
  Widget _buildLeadSuccessStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            const Text(
              "Lead Created Successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Name: $customerName\nMobile: $customerMobile\nEmail: $customerEmail",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.customerAddress,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      lead = customerName;
                      setState(() => currentStep = FieldSheetStep.lcoName);
                    },
                    child: const Text("Continue →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 11: LCO / Corporate Name
  Widget _buildLcoNameStep() {
    final controller = TextEditingController(text: lcoName);

    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "LCO / Corporate Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter LCO or Corporate name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => lcoName = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (lead != null && leadList.contains(lead)) {
                        setState(() => currentStep = FieldSheetStep.lead);
                      } else {
                        setState(
                          () => currentStep = FieldSheetStep.createLeadSuccess,
                        );
                      }
                    },
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (lcoName != null && lcoName!.isNotEmpty) {
                        setState(
                          () => currentStep = FieldSheetStep.leadDetails,
                        );
                      } else {
                        _showSnackBar("Please enter LCO/Corporate name");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 12: Lead Details
  Widget _buildLeadDetailsStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lead Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Contact: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: customerMobile ?? "N/A"),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Address: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: customerAddress ?? "N/A"),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Hub: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: hub ?? "N/A"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.lcoName),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => currentStep = FieldSheetStep.problem),
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 13: Problem Selection
  Widget _buildProblemSelectionStep() {
    return ProblemSelectionCard(
      onContinue: () => setState(() => currentStep = FieldSheetStep.inTime),
      onBack: () => setState(() => currentStep = FieldSheetStep.leadDetails),
    );
  }

  // STEP 14: In Time
  Widget _buildInTimeStep() {
    return InTimeCard(
      onSend: (time) {
        setState(() => currentStep = FieldSheetStep.feedback);
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.problem),
    );
  }

  // STEP 15: Feedback
  Widget _buildFeedbackStep() {
    return FeedbackCard(
      onSend: (feedback) {
        setState(() {
          selectedFeedback = feedback;
          currentStep = FieldSheetStep.remarks;
        });
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.inTime),
    );
  }

  // STEP 16: Remarks
  Widget _buildRemarksStep() {
    return RemarksCard(
      onSend: (remarks) {
        setState(() => currentStep = FieldSheetStep.uploadChoice);
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.feedback),
    );
  }

  // STEP 17: Upload Choice
  Widget _buildUploadChoiceStep() {
    return UploadOptionCard(
      onSend: (value) {
        if (value == "Yes, add documents") {
          setState(() => currentStep = FieldSheetStep.uploadDocument);
        } else {
          setState(() => currentStep = FieldSheetStep.otpMobile);
        }
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.remarks),
    );
  }

  // STEP 18: Upload Documents
  Widget _buildUploadDocumentsStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Documents",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload Document"),
            ),
            const SizedBox(height: 20),
            if (documents.isNotEmpty) ...[
              const Text(
                "Uploaded Documents:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final file = documents[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.insert_drive_file,
                        color: Colors.blue,
                      ),
                      title: Text(file.path.split('/').last),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            setState(() => documents.removeAt(index)),
                      ),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(
                      () => currentStep = FieldSheetStep.uploadChoice,
                    ),
                    child: const Text("← Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (documents.isNotEmpty) {
                        setState(() => currentStep = FieldSheetStep.uploadMore);
                      } else {
                        _showSnackBar("Please upload at least one document");
                      }
                    },
                    child: const Text("Next →"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // STEP 19: Upload More
  Widget _buildUploadMoreStep() {
    return UploadMoreCard(
      onSend: (value) {
        if (value == "Yes, add more") {
          setState(() => currentStep = FieldSheetStep.uploadDocument);
        } else {
          setState(() => currentStep = FieldSheetStep.otpMobile);
        }
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.uploadDocument),
    );
  }

  // STEP 20: Mobile OTP
  Widget _buildMobileOtpStep() {
    return MobileOtpCard(
      onSend: (mobile) {
        _sendOTP(mobile);
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.uploadChoice),
    );
  }

  // STEP 21: OTP Verification
  Widget _buildOtpVerificationStep() {
    return OtpVerificationCard(
      mobile: mobileNumber ?? "",
      onVerify: (otpCode) {
        _verifyOTP(otpCode);
      },
      onResend: _resendOTP,
      onBack: () => setState(() => currentStep = FieldSheetStep.otpMobile),
    );
  }

  // STEP 22: GPS
  Widget _buildGpsStep() {
    return GpsRetryCard(
      onSelect: (option) {
        if (option == "Retry Submit") {
          _checkGpsAndSubmit();
        } else {
          setState(() => currentStep = FieldSheetStep.otp);
        }
      },
      onBack: () => setState(() => currentStep = FieldSheetStep.otp),
    );
  }

  // STEP 23: Completed
  Widget _buildCompletedStep() {
    return Card(
      color: const Color(0xffEEF3FB),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text(
              "DVR Successfully Submitted!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "DVR ID: ${createdDvrId ?? 'N/A'}",
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              "GPS Location captured successfully",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================
  // Helper Methods
  // ========================================

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          documents.addAll(
            result.paths.where((e) => e != null).map((e) => File(e!)),
          );
        });
        _showSnackBar("${result.files.length} document(s) uploaded");
      }
    } catch (e) {
      _showSnackBar("Error picking files: $e");
    }
  }

  void _showLeadSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Lead Created Successfully!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Name: ${customerName ?? 'N/A'}"),
            Text("Mobile: ${customerMobile ?? 'N/A'}"),
            Text("Email: ${customerEmail ?? 'N/A'}"),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(
                      () => currentStep = FieldSheetStep.customerAddress,
                    );
                  },
                  child: const Text("← Back"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    lead = customerName;
                    setState(
                      () => currentStep = FieldSheetStep.createLeadSuccess,
                    );
                  },
                  child: const Text("Continue →"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _checkGpsAndSubmit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Checking GPS location..."),
          ],
        ),
      ),
    );

    // Simulate GPS check
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      // In real app, get actual GPS coordinates here
      // For demo, using hardcoded values
      meetingLatitude = "22.572645";
      meetingLongitude = "88.363892";
      meetingAddress = "Kolkata, West Bengal, India";

      // Submit DVR
      _submitDVR();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}