class StudentModel {
  final String? id;
  final String fullname;
  final String gender;
  final double required;
  final double paid;
  final double? remaining;
  final String phone;
  final String? createdDate;
  final String? createdTime;
  final String? updateDate;
  final String? updateTime;

  // ✅ Constructor for reading full student info from backend
  StudentModel({
    this.id,
    required this.fullname,
    required this.gender,
    required this.required,
    required this.paid,
    this.remaining,
    required this.phone,
    this.createdDate,
    this.createdTime,
    this.updateDate,
    this.updateTime,
  });

  // ✅ Used only when sending new student to API
  StudentModel.create({
    required this.fullname,
    required this.gender,
    required this.required,
    required this.paid,
    required this.phone,
  }) : id = null,
       remaining = null,
       createdDate = null,
       createdTime = null,
       updateDate = null,
       updateTime = null;

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      fullname: json['fullname'],
      gender: json['gender'],
      required: (json['required'] as num).toDouble(),
      paid: (json['paid'] as num).toDouble(),
      remaining:
          json['remaining'] != null
              ? (json['remaining'] as num).toDouble()
              : null,
      phone: json['phone'],
      createdDate: json['createdDate'],
      createdTime: json['createdTime'],
      updateDate: json['updateDate'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'required': required,
      'paid': paid,
      'phone': phone,
    };
  }
}
