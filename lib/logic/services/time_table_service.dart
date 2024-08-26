import 'package:dio/dio.dart';

class TimeTableService {
  final String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  final dio = Dio();
  Future<void> createTimeTable(int groupId, int roomId, int dayId,
      String startTime, String endTime, String token) async {
    print(groupId);
    print(roomId);
    print(dayId);
    print(startTime.runtimeType);
    print(endTime);
    try {
      final url = '$baseUrl/group-classes';
      final responce = await dio.post(
        url,
        data: {
          "group_id": groupId,
          "room_id": roomId,
          "day_id": dayId,
          "start_time": startTime,
          "end_time": endTime
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
