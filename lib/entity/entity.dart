abstract class Entity {
  late final int id;

  Entity({required this.id});

  Map<String, dynamic> toJson();
}
