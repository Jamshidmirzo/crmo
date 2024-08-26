import 'package:dio/dio.dart';

class RoomService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();

  Future<void> addRoom(
      String accessToken, String name, String desc, int capacity) async {
    final url = '$baseUrl/rooms';
    // ignore: unused_local_variable
    final responce = await dio.post(
      url,
      data: {'name': name, 'description': desc, 'capacity': capacity},
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getRooms(String accessToken) async {
    final url = '$baseUrl/rooms';
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

  Future<void> deleteRooms(String accessToken, int id) async {
    final url = '$baseUrl/rooms/$id';
    final responce = await dio.delete(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return responce.data;
  }
}
