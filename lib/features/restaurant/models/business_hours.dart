import 'package:event_mgmt_services_app/features/restaurant/enum/weekday.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusinessHours {
  final TimeOfDay start;
  final TimeOfDay end;
  final Weekday weekday;

  BusinessHours({
    required this.start,
    required this.end,
    required this.weekday,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    try {
      String startStr = json['start'] as String;
      String endStr = json['end'] as String;

      return BusinessHours(
        start: TimeOfDay(
            hour: int.parse(startStr.substring(0, 2)), minute: int.parse(startStr.substring(2))),
        end: TimeOfDay(hour: int.parse(endStr.substring(0, 2)), minute: int.parse(endStr.substring(2))),
        weekday: Weekday.values[json['day'] as int],
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error parsing BusinessHours: $e');
      }
      rethrow;
    }
  }

  @override
  String toString() {
    String formattedStart =
        '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    String formattedEnd =
        '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    return 'BusinessHours{\n'
        '  Weekday: ${weekday.toString().split('.').last},\n' 
        '  Start: $formattedStart,\n'
        '  End: $formattedEnd\n'
        '}';
  }
}
