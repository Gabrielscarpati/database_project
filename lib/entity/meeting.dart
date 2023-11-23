import 'entity.dart';

class Meeting extends Entity {
  final int advisorId;
  final int employee1;
  final int employee2;
  final int employee3;
  final DateTime meetingTime;

  Meeting({
    required super.id,
    required this.advisorId,
    required this.employee1,
    required this.employee2,
    required this.employee3,
    required this.meetingTime,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['meetingId'] as int,
      advisorId: json['advisorId'] as int,
      employee1: json['employee1'] as int,
      employee2: json['employee2'] as int,
      employee3: json['employee3'] as int,
      meetingTime: DateTime.parse(json['meetingTime'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'meetingId': id,
      'advisorId': advisorId,
      'employee1': employee1,
      'employee2': employee2,
      'employee3': employee3,
      'meetingTime': meetingTime.toIso8601String(),
    };
  }

  Meeting copyWith({
    int? id,
    int? advisorId,
    int? employee1,
    int? employee2,
    int? employee3,
    DateTime? meetingTime,
  }) {
    return Meeting(
      id: id ?? this.id,
      advisorId: advisorId ?? this.advisorId,
      employee1: employee1 ?? this.employee1,
      employee2: employee2 ?? this.employee2,
      employee3: employee3 ?? this.employee3,
      meetingTime: meetingTime ?? this.meetingTime,
    );
  }
}
