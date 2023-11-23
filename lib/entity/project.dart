import 'entity.dart';

class Project extends Entity {
  final DateTime dateCreated;
  final DateTime dateDue;
  final String title;
  final int advisorId;

  Project({
    required super.id,
    required this.dateCreated,
    required this.dateDue,
    required this.title,
    required this.advisorId,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['projectId'] as int,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateDue: DateTime.parse(json['dateDue'] as String),
      title: json['title'] as String,
      advisorId: json['advisorId'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'projectId': id,
      'dateCreated': dateCreated.toIso8601String(),
      'dateDue': dateDue.toIso8601String(),
      'title': title,
      'advisorId': advisorId,
    };
  }

  Project copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateDue,
    String? title,
    int? advisorId,
  }) {
    return Project(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateDue: dateDue ?? this.dateDue,
      title: title ?? this.title,
      advisorId: advisorId ?? this.advisorId,
    );
  }
}
