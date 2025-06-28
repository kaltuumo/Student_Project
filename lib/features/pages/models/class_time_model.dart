class ClassTimeModel {
  final String? id;
  final String subject;
  final String teacher;
  final String room;
  final String day;
  final String startTime;
  final String endTime;

  ClassTimeModel({
    this.id,
    required this.subject,
    required this.teacher,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory ClassTimeModel.fromJson(Map<String, dynamic> json) {
    return ClassTimeModel(
      id: json['_id'],
      subject: json['subject'],
      teacher: json['teacher'],
      room: json['room'],
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'teacher': teacher,
      'room': room,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
