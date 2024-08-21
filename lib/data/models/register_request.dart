// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterRequest {
  final String name;
  final String phone;
  final String password;
  final String password_confirmation;
  int? role_id;
  RegisterRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.password_confirmation,
    this.role_id,
  });

  RegisterRequest copyWith({
    String? name,
    String? phone,
    String? password,
    String? password_confirmation,
    int? role_id,
  }) {
    return RegisterRequest(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      password_confirmation:
          password_confirmation ?? this.password_confirmation,
      role_id: role_id ?? this.role_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': password_confirmation,
      'role_id': role_id,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      name: map['name'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      password_confirmation: map['password_confirmation'] as String,
      role_id: map['role_id'] != null ? map['role_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterRequest(name: $name, phone: $phone, password: $password, password_confirmation: $password_confirmation, role_id: $role_id)';
  }

  @override
  bool operator ==(covariant RegisterRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.password == password &&
        other.password_confirmation == password_confirmation &&
        other.role_id == role_id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        password_confirmation.hashCode ^
        role_id.hashCode;
  }
}
