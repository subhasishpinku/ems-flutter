class ApiEndpoints {
  // ================= AUTH =================
  static const String login = "auth/login.php";
  static const String logout = "auth/logout.php";
  static const String me = "auth/me.php";
  static const String refreshToken = "auth/refresh.php";
  static const String forgotPassword = "auth/reset-password.php";

  // ================= PROFILE =================
  static const String profile = "profile/index.php";

  // ================= DASHBOARD =================
  static const String dashboard = "dashboard/dashboard.php";
    static const String dashboardMonths = "dashboard/months.php";


  // ================= ATTENDANCE =================
  static const String punchIn = "attendance/punch-in.php";
  static const String punchOut = "attendance/punch-out.php";
  static const String attendanceReport = "attendance/report.php";

  // ================= LOCATION =================
  static const String locationHubs = "location/hubs.php";

  // ================= DVR =================
  static const String dvrIndex = "dvr/index.php";
  static const String dvrMetadata = "dvr/metadata.php";
  static const String dvrLeadDetails = "dvr/lead-details.php";
  static const String dvrCompanyDetails = "dvr/company-details.php";
  static const String dvrOtp = "dvr/otp.php";
  static const String dvrCreate = "dvr/create.php";
  static const String dvrList = "dvr/list.php";
  static const String dvrConfirmList = "dvr/confirm-list.php";
  static const String dvrShow = "dvr/show.php";
  static const String dvrUpdate = "dvr/update.php";
  static const String dvrConfirm = "dvr/confirm.php";
  static const String dvrDocuments = "dvr/documents.php";

  // ================= DOCKET =================
  static const String docketList = "docket/list.php";
  static const String docketDetails = "docket/details.php";
  static const String docketClose = "docket/close.php";
  static const String docketHold = "docket/hold.php";
  static const String docketRelease = "docket/release.php";
  static const String docketMaterials = "docket/materials.php";

  // ================= LEAD =================
  static const String leadPlatforms = "lead/platforms.php";
  static const String leadInterests = "lead/interests.php";
  static const String leadHubs = "lead/hubs.php";
  static const String leadCreate = "lead/create.php";
  static const String leadList = "lead/list.php";

  // ================= FEASIBILITY =================
  static const String feasibilityCustomers = "feasibility/customers.php";
  static const String feasibilityHubs = "feasibility/hubs.php";
  static const String feasibilityCreate = "feasibility/create.php";
  static const String feasibilityList = "feasibility/list.php";

  // ================= INSTALLATION =================
  static const String installationCreate = "installation/create.php";
  static const String installationList = "installation/list.php";

  // ================= TASK =================
  static const String taskList = "tasks/list.php";
  static const String taskSummary = "tasks/summary.php";
  static const String taskMonthly = "tasks/monthly.php";
  static const String taskDetail = "tasks/detail.php";
  static const String taskCreate = "tasks/create.php";
  static const String taskComment = "tasks/comment.php";
  static const String taskChangeStatus = "tasks/change-status.php";
  static const String taskUpdateDetail = "tasks/update-detail.php";
  static const String taskTypes = "tasks/types.php";
  static const String taskStatuses = "tasks/statuses.php";
  static const String taskEmployees = "tasks/employees.php";

  // ================= VEHICLE =================
  static const String vehicleMetadata = "vehicle/metadata.php";
  static const String vehicleLastKm = "vehicle/last-km.php";
  static const String vehicleCreate = "vehicle/create.php";
  static const String vehicleList = "vehicle/list.php";
  static const String vehicleShow = "vehicle/show.php";

  // ================= LEAVE =================
  static const String leaveCreate = "leave/create.php";
  static const String leaveList = "leave/list.php";
  static const String leaveShow = "leave/show.php";
  static const String leaveStatus = "leave/status.php";
  static const String leaveEmployees = "leave/employees.php";

  // ================= LCO =================
  static const String lcoCreate = "lco/create.php";
  static const String lcoList = "lco/list.php";
  static const String lcoUpdate = "lco/update.php";

  // ================= HUB =================
  static const String hubCreate = "hub/create.php";
  static const String hubList = "hub/list.php";
  static const String hubUpdate = "hub/update.php";

  // ================= REPORTS =================
  static const String fieldSheetReport = "reports/field-sheet.php";

  // ================= EMPLOYEE LOCATION =================
  static const String employeeLocationCreate = "employee_location/create.php";
}
