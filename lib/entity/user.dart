import 'entity.dart';

class AppUser extends Entity {
  final String lastName;
  final String firstName;
  final String email;
  final String phone;
  final DateTime dob;
  final int? projectId;

  AppUser({
    required super.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.dob,
    required this.projectId,
    //{employeeid: 2, firstname: Akmal, lastname: Kurbanov, email: a@gmail.com}
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['userid'] as int,
      lastName: json['last_name'] as String,
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] ?? '',
      dob: DateTime.parse(json['dob'] ?? '0000-00-00'),
      projectId: json['projectid'] as int?,
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
      'projectid': projectId,
    };
  }

  AppUser copyWith({
    int? id,
    String? lastName,
    String? firstName,
    String? email,
    String? phone,
    DateTime? dob,
    int? projectId,
  }) {
    return AppUser(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      projectId: projectId ?? this.projectId,
    );
  }
}
