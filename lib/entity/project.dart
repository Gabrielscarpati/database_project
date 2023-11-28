import 'entity.dart';

class Project extends Entity {
  final DateTime dateCreated;
  final DateTime dateDue;
  final String title;
  final int advisorId;
  final double projectCompleted;

  Project({
    required super.id,
    required this.dateCreated,
    required this.dateDue,
    required this.title,
    required this.advisorId,
    required this.projectCompleted,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['projectid'] as int,
      dateCreated: DateTime.parse(json['projectdatecreated'] as String),
      dateDue: DateTime.parse(json['projectdatedue'] as String),
      title: json['projecttitle'] as String,
      advisorId: json['advisorid'] as int,
      projectCompleted:
          double.parse(json['projectcompleted'].toDouble().toStringAsFixed(2)) *
              100,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'projectid': id,
      'projectdatecreated': dateCreated.toIso8601String(),
      'projectdatedue': dateDue.toIso8601String(),
      'projecttitle': title,
      'advisorid': advisorId,
      'projectcompleted': projectCompleted,
    };
  }

  Project copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateDue,
    String? title,
    int? advisorId,
    double? projectCompleted,
  }) {
    return Project(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateDue: dateDue ?? this.dateDue,
      title: title ?? this.title,
      advisorId: advisorId ?? this.advisorId,
      projectCompleted: projectCompleted ?? this.projectCompleted,
    );
  }
}
