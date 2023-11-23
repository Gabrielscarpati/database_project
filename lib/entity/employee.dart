import 'entity.dart';

class Employee extends Entity {
  final int projectId;

  Employee({
    required super.id,
    required this.projectId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['employeeId'],
      projectId: json['projectId'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'employeeId': id,
      'projectId': projectId,
    };
  }

  Employee copyWith({
    int? id,
    int? projectId,
  }) {
    return Employee(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
    );
  }
}
