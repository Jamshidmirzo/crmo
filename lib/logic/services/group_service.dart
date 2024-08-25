import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();
  Future<void> addGroup(
    String accessToken,
    String name,
    int mainTeacherId,
    int assistantTeacherId,
  ) async {
    final url = '$baseUrl/groups';
    // ignore: unused_local_variable
    final responce = await dio.post(
      url,
      data: {
        'name': name,
        'main_teacher_id': mainTeacherId,
        'assistant_teacher_id': assistantTeacherId
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
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
