class AttendanceModel {
  final String studentId;
  final String date;
  final String status;

  AttendanceModel({
    required this.studentId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {'studentId': studentId, 'date': date, 'status': status};
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentId: json['studentId'],
      date: json['date'],
      status: json['status'],
    );
  }
}
