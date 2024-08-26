// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class TimeTableRequest {
  int group_id;
  int room_id;
  int day_id;
  String start_time;
  String end_time;
  TimeTableRequest({
    required this.group_id,
    required this.room_id,
    required this.day_id,
    required this.start_time,
    required this.end_time,
  });

  TimeTableRequest copyWith({
    int? group_id,
    int? room_id,
    int? day_id,
    String? start_time,
    String? end_time,
  }) {
    return TimeTableRequest(
      group_id: group_id ?? this.group_id,
      room_id: room_id ?? this.room_id,
      day_id: day_id ?? this.day_id,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group_id': group_id,
      'room_id': room_id,
      'day_id': day_id,
      'start_time': start_time,
      'end_time': end_time,
    };
  }

  factory TimeTableRequest.fromMap(Map<String, dynamic> map) {
    return TimeTableRequest(
      group_id: map['group_id'] as int,
      room_id: map['room_id'] as int,
      day_id: map['day_id'] as int,
      start_time: map['start_time'] as String,
      end_time: map['end_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeTableRequest.fromJson(String source) => TimeTableRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeTableRequest(group_id: $group_id, room_id: $room_id, day_id: $day_id, start_time: $start_time, end_time: $end_time)';
  }

  @override
  bool operator ==(covariant TimeTableRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.group_id == group_id &&
      other.room_id == room_id &&
      other.day_id == day_id &&
      other.start_time == start_time &&
      other.end_time == end_time;
  }

  @override
  int get hashCode {
    return group_id.hashCode ^
      room_id.hashCode ^
      day_id.hashCode ^
      start_time.hashCode ^
      end_time.hashCode;
  }
}
