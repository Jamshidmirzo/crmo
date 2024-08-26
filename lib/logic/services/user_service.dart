import 'dart:io';
import 'package:crmo/data/models/admin.dart';
import 'package:crmo/data/models/student.dart';
import 'package:crmo/data/models/teacher_responce.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final Dio dio;

  UserService({Dio? dio}) : dio = dio ?? Dio();

  Future<Map<String, dynamic>> getUser(String accessToken) async {
    try {
      final String url = '$baseUrl/user';
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch user: ${response.statusMessage}');
      }
      return response.data;
    } catch (e) {
      throw Exception('Error during getUser: $e');
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    required String phone,
    File? photo,
    required String accessToken,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('name', name!),
        MapEntry('phone', phone),
      ]);

      if (email != null) {
        formData.fields.add(MapEntry('email', email));
      }

      if (photo != null) {
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: 'profile_photo.${photo.path.split('.').last}',
            ),
          ),
        );
      }

      // ignore: unused_local_variable
      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/profile/update",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<TeacherResponse> getTeachers(String accessToken) async {
    final url = '$baseUrl/users?role_id=2';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch user: ${response.statusMessage}');
      }
      return TeacherResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Error during getUser: $e');
    }
  }

  Future<StudentResponse> getStudents(String token) async {
    final url = '$baseUrl/users?role_id=1';
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return StudentResponse.fromJson(response.data);
  }

  Future<AdminResponse> getAdmins(String token) async {
    final url = '$baseUrl/users?role_id=3';
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return AdminResponse.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getMyGroups(String token) async {
    final url = '$baseUrl/student/groups';
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final shared = await SharedPreferences.getInstance();
    final token = shared.getString('token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Continue the request
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Continue the response
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
