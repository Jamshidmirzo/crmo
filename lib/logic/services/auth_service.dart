import 'package:crmo/data/models/register_request.dart';
import 'package:dio/dio.dart';

class AuthService {
  final baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();
  Future<Map<String, dynamic>> signUp(RegisterRequest request) async {
    print(request.toMap());
    try {
      const url = 'http://millima.flutterwithakmaljon.uz/api/register';
      final response = await dio.post(
        url,
        data: request.toMap(),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('The requested URL was not found on the server.');
      }
      throw Exception('Failed to register: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = '$baseUrl/login';
    final responce = await dio.post(url, data: {
      'email': email,
      'password': password,
    });
    return _handleResponse(responce);
  }

  Future<void> signOut(String accessToken) async {
    final url = '$baseUrl/logout';
    final responce = await dio.post(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (responce.statusCode != 200) {
      throw Exception('Faileded equest:${responce.statusCode}');
    }
  }

  Map<String, dynamic> _handleResponse(Response responce) {
    final Map<String, dynamic> decoded = responce.data;
    if (responce.statusCode != 200) {
      throw Exception('Faileded equest:${decoded['message']}');
    }
    return decoded;
  }
}
