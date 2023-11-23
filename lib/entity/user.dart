import 'entity.dart';

class AppUser extends Entity {
  final String lastName;
  final String firstName;
  final String email;
  final String phone;
  final DateTime dob;

  AppUser({
    required super.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.dob,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['userid'] as int,
      lastName: json['last_name'] as String,
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dob: DateTime.parse(json['dob'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userid': id,
      'last_name': lastName,
      'first_name': firstName,
      'email': email,
      'phone': phone,
      'dob': dob.toIso8601String(),
    };
  }

  AppUser copyWith({
    int? id,
    String? lastName,
    String? firstName,
    String? email,
    String? phone,
    DateTime? dob,
  }) {
    return AppUser(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
    );
  }
}
