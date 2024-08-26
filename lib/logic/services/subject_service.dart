import 'package:dio/dio.dart';

class SubjectService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();
  Future<void> addSubject(String name, String accessToken) async {
    final url = '$baseUrl/subjects';
     await dio.post(
      url,
      data: {
        'name': name,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getSubjects(String accessToken) async {
    final url = '$baseUrl/subjects';
    final responce = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return responce.data;
  }

  Future<void> deleteSubject(int id, String accessToken) async {
    final url = '$baseUrl/subjects/$id';
     await dio.delete(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}
