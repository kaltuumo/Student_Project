class StudentModel {
  final String? id;
  final String fullname;
  final String gender;
  final String education;
  final double required;
  final double paid;
  final String phone;
  final String? createdDate;
  final String? createdTime;
  final String? updateDate;
  final String? updateTime;

  double get remaining => required - paid;

  // Determine if the student has "Approved" or "Pending" status
  String get status =>
      (remaining != null && remaining == 0) ? 'Approved' : 'Pending';

  // Constructor for reading full student info from the backend
  StudentModel({
    this.id,
    required this.fullname,
    required this.gender,
    required this.education,
    required this.required,
    required this.paid,
    required this.phone,
    this.createdDate,
    this.createdTime,
    this.updateDate,
    this.updateTime,
  });

  // Constructor for sending new student to the API (without ID and timestamps)
  StudentModel.create({
    required this.fullname,
    required this.gender,
    required this.education,
    required this.required,
    required this.paid,
    required this.phone,
  }) : id = null,
       createdDate = null,
       createdTime = null,
       updateDate = null,
       updateTime = null;

  // Factory constructor to parse data from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      fullname: json['fullname'],
      gender: json['gender'],
      education: json['education'],
      required: (json['required'] as num).toDouble(),
      paid: (json['paid'] as num).toDouble(),

      phone: json['phone'],
      createdDate: json['createdDate'],
      createdTime: json['createdTime'],
      updateDate: json['updateDate'],
      updateTime: json['updateTime'],
    );
  }

  // Convert model to JSON format for API requests
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'education': education,
      'required': required,
      'paid': paid,
      'phone': phone,
    };
  }
}
