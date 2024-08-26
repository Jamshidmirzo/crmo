import 'package:crmo/data/models/role.dart';

class Admin {
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

  Admin({
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

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
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
class AdminResponse {
  final bool success;
  final List<Admin> data;
  final String message;

  AdminResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AdminResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Admin> adminList = list.map((i) => Admin.fromJson(i)).toList();

    return AdminResponse(
      success: json['success'],
      data: adminList,
      message: json['message'],
    );
  }
}


