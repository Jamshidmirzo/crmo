import 'package:crmo/data/models/register_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();
  Future<Map<String, dynamic>> signUp(RegisterRequest request) async {
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
      'phone': email,
      'password': password,
    });
    return _handleResponse(responce);
  }

  Future<void> signOut(String accessToken) async {
    try {
      final String url = '$baseUrl/logout';
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed request: ${response.statusCode}');
      }

      final shared = await SharedPreferences.getInstance();
      await shared.clear();
    } catch (e) {
      rethrow; 
    }
  }

  Future<Map<String, dynamic>> _handleResponse(Response responce) async {
    final Map<String, dynamic> decoded = responce.data;
    if (responce.statusCode != 200) {
      throw Exception('Faileded equest:${decoded['message']}');
    }
    final shared = await SharedPreferences.getInstance();
    shared.setString('token', decoded['data']['token']);
    return decoded;
  }
}

class DioInterCeptors extends Interceptor {
  @override
  // ignore: unnecessary_overrides
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }
}
