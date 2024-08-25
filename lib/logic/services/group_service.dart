import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GroupService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final Dio dio;

  GroupService()
      : dio = Dio() {
    dio.interceptors.add(DioInterceptors());
  }

  Future<Map<String, dynamic>> getTeachers() async {
    final url = '$baseUrl/users/role_id=2';
    final response = await dio.get(url);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _handleResponse(Response response) async {
    final Map<String, dynamic> decoded = response.data;
    if (response.statusCode != 200) {
      throw Exception('Failed request: ${decoded['message']}');
    }

    return decoded;
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
    // Handle the error and continue
    handler.next(err);
  }
}
