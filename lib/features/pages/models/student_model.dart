class StudentModel {
  final String? id;
  final String fullname;
  final String required;
  final String gender;
  final String paid;
  final String remaining;
  final String phone;
  final String? createdAt;
  final String? updatedAt;

  StudentModel({
    this.id,
    required this.fullname,
    required this.required,
    required this.paid,
    required this.remaining,
    required this.gender,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      fullname: json['fullname'],
      gender: json['gender'],
      required: json['required'],
      paid: json['paid'],
      remaining: json['remaining'],
      phone: json['phone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'required': required,
      'paid': paid,
      'remaining': remaining,
      'phone': phone,
    };
  }
}
