import 'package:crmo/data/models/role.dart';

class Teacher {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String? photo;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int roleId;
  final Role? role; 

  Teacher({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    this.role, 
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roleId: json['role_id'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null, // Handle null role
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role_id': roleId,
      'role': role?.toJson(), 
    };
  }
}
