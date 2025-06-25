class StudentReportModel {
  final int totalStudents;
  final int activeStudents;
  final int inactiveStudents;
  final int pendingStudent;
  final int paidStudents;
  final int balanceDueStudents;
  final int fullyPaidStudents;

  StudentReportModel({
    required this.totalStudents,
    required this.activeStudents,
    required this.inactiveStudents,
    required this.pendingStudent,
    required this.paidStudents,
    required this.balanceDueStudents,
    required this.fullyPaidStudents,
  });

  factory StudentReportModel.fromJson(Map<String, dynamic> json) {
    return StudentReportModel(
      totalStudents: json['totalStudents'] ?? 0, // Default to 0 if null
      activeStudents: json['activeStudents'] ?? 0,
      inactiveStudents: json['inactiveStudents'] ?? 0,
      pendingStudent: json['pendingStudents'] ?? 0,
      paidStudents: json['paidStudents'] ?? 0,
      balanceDueStudents: json['balanceDueStudents'] ?? 0,
      fullyPaidStudents: json['fullyPaidStudents'] ?? 0,
    );
  }
}
