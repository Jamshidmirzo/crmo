import 'package:crmo/data/models/role.dart';

class Student {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String? photo;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final int roleId;
  final Role role;

  Student({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.role,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      roleId: json['role_id'],
      role: Role.fromJson(json['role']),
    );
  }
}

class StudentResponse {
  final bool success;
  final List<Student> data;
  final String message;

  StudentResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Student> studentList = list.map((i) => Student.fromJson(i)).toList();

    return StudentResponse(
      success: json['success'],
      data: studentList,
      message: json['message'],
    );
  }
}
