import 'entity.dart';

class Task extends Entity {
  final int projectId;
  final int employeeId;
  final String name;
  final String description;
  final DateTime dateCreated;
  final DateTime dateDue;

  Task({
    required super.id,
    required this.projectId,
    required this.employeeId,
    required this.name,
    required this.description,
    required this.dateCreated,
    required this.dateDue,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['taskId'] as int,
      projectId: json['projectId'] as int,
      employeeId: json['employeeId'] as int,
      name: json['taskName'] as String,
      description: json['taskDescription'] as String,
      dateCreated: DateTime.parse(json['taskDateCreated'] as String),
      dateDue: DateTime.parse(json['taskDateDue'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskId': id,
      'projectId': projectId,
      'employeeId': employeeId,
      'taskName': name,
      'taskDescription': description,
      'taskDateCreated': dateCreated.toIso8601String(),
      'taskDateDue': dateDue.toIso8601String(),
    };
  }

  Task copyWith({
    int? id,
    int? projectId,
    int? employeeId,
    String? name,
    String? description,
    DateTime? dateCreated,
    DateTime? dateDue,
  }) {
    return Task(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      description: description ?? this.description,
      dateCreated: dateCreated ?? this.dateCreated,
      dateDue: dateDue ?? this.dateDue,
    );
  }
}
