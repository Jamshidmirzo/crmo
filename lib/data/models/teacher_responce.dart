import 'package:crmo/data/models/teacher.dart';

class TeacherResponse {
  final bool success;
  final List<Teacher> data;
  final String message;

  TeacherResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TeacherResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Teacher> teachersList = list.map((i) => Teacher.fromJson(i)).toList();

    return TeacherResponse(
      success: json['success'],
      data: teachersList,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((teacher) => teacher.toJson()).toList(),
      'message': message,
    };
  }
}
