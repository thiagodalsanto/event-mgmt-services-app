import 'package:intl/intl.dart';

class EventDate {
  final DateTime start;
  final String when;

  EventDate({
    required this.start,
    required this.when,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
      start: DateFormat('MMM dd yyyy')
          .parse("${json['start_date']} ${DateTime.now().year}"),
      when: json['when'],
    );
  }
}
