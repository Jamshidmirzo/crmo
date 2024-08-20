import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterRequest {
  final String name;
  final String phone;
  final String password;
  final String password_confirmation;
  RegisterRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.password_confirmation,
  });

  RegisterRequest copyWith({
    String? name,
    String? phone,
    String? password,
    String? password_confirmation,
  }) {
    return RegisterRequest(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      password_confirmation:
          password_confirmation ?? this.password_confirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      name: map['name'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      password_confirmation: map['password_confirmation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterRequest(name: $name, phone: $phone, password: $password, password_confirmation: $password_confirmation)';
  }

  @override
  bool operator ==(covariant RegisterRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.password == password &&
        other.password_confirmation == password_confirmation;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        password_confirmation.hashCode;
  }
}
