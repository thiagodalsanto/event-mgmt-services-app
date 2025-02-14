import 'package:calendar_mgmt_services_app/features/event/models/event_date.dart';

class Event {
  final String title;
  final EventDate date;
  final List<String> address;
  final String link;
  final String thumbnail;

  Event({
    required this.title,
    required this.date,
    required this.address,
    required this.link,
    required this.thumbnail,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: EventDate.fromJson(json['date']),
      address: List<String>.from(json['address']),
      link: json['link'],
      thumbnail: json['thumbnail'],
    );
  }
}
