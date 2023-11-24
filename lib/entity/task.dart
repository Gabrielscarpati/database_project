import 'entity.dart';

class Task extends Entity {
  final int projectId;
  final int employeeId;
  final String name;
  final String description;
  final DateTime dateCreated;
  final DateTime dateDue;
  final String lastname;
  final String firstname;

  Task({
    required super.id,
    required this.projectId,
    required this.employeeId,
    required this.name,
    required this.description,
    required this.dateCreated,
    required this.dateDue,
    required this.lastname,
    required this.firstname,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    print(json);
    return Task(
        id: json['taskid'] as int,
        projectId: json['projectid'] as int,
        employeeId: json['employeeid'] as int,
        name: json['taskname'] as String,
        description: json['taskdescription'] as String,
        dateCreated: DateTime.parse(json['taskdatecreated'] as String),
        dateDue: DateTime.parse(json['taskdatedue'] as String),
        lastname: json['lastname'] ?? '',
        firstname: json['firstname'] ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskid': id,
      'projectid': projectId,
      'employeeid': employeeId,
      'taskname': name,
      'taskdescription': description,
      'taskdatecreated': dateCreated.toIso8601String(),
      'taskdatedue': dateDue.toIso8601String(),
      'lastname': lastname,
      'firstname': firstname,
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
    String? lastname,
    String? firstname,
  }) {
    return Task(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      description: description ?? this.description,
      dateCreated: dateCreated ?? this.dateCreated,
      dateDue: dateDue ?? this.dateDue,
      lastname: lastname ?? this.lastname,
      firstname: firstname ?? this.firstname,
    );
  }
}
