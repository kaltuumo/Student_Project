class StudentReportModel {
  final int totalStudents;
  final int activeStudents;
  final int inactiveStudents;
  final int paidStudents;
  final int balanceDueStudents;
  final int fullyPaidStudents;

  StudentReportModel({
    required this.totalStudents,
    required this.activeStudents,
    required this.inactiveStudents,
    required this.paidStudents,
    required this.balanceDueStudents,
    required this.fullyPaidStudents,
  });

  factory StudentReportModel.fromJson(Map<String, dynamic> json) {
    return StudentReportModel(
      totalStudents: json['totalStudents'],
      activeStudents: json['activeStudents'],
      inactiveStudents: json['inactiveStudents'],
      paidStudents: json['paidStudents'],
      balanceDueStudents: json['balanceDueStudents'],
      fullyPaidStudents: json['fullyPaidStudents'],
    );
  }
}
