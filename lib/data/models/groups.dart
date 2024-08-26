import 'package:crmo/data/models/student.dart';
import 'package:crmo/data/models/teacher.dart';
class Group {
  final int id;
  final String name;
  final int mainTeacherId;
  final int assistantTeacherId;
  final String createdAt;
  final String updatedAt;
  final Teacher mainTeacher;
  final Teacher assistantTeacher;
  final List<Student> students;

  Group({
    required this.id,
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.students,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    var studentsList = json['students'] as List?;
    List<Student> studentList = studentsList != null
        ? studentsList.map((i) => Student.fromJson(i)).toList()
        : [];

    return Group(
      id: json['id'],
      name: json['name'],
      mainTeacherId: json['main_teacher_id'],
      assistantTeacherId: json['assistant_teacher_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mainTeacher: Teacher.fromJson(json['main_teacher']),
      assistantTeacher: Teacher.fromJson(json['assistant_teacher']),
      students: studentList,
    );
  }
}

class GroupResponse {
  final bool success;
  final List<Group> data;
  final String message;

  GroupResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
  var groupsList = json['data'] as List?;
  List<Group> groupList = groupsList != null
      ? groupsList.map((i) => Group.fromJson(i)).toList()
      : []; // Handle null here

  return GroupResponse(
    success: json['success'],
    data: groupList,
    message: json['message'],
  );
}

}
