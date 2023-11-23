import 'entity.dart';

class Advisor extends Entity {
  final String name;

  Advisor({
    required super.id,
    required this.name,
  });

  factory Advisor.fromJson(Map<String, dynamic> json) {
    return Advisor(
      id: json['advisorId'] as int,
      name: json['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'advisorId': id,
      'name': name,
    };
  }

  Advisor copyWith({
    int? id,
    String? name,
  }) {
    return Advisor(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
