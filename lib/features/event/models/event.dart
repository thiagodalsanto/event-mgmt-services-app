import 'package:event_mgmt_services_app/features/event/models/event_date.dart';
import 'package:event_mgmt_services_app/features/event/models/event_location.dart';

class Event {
  final String title;
  final EventDate date;
  final List<String> address;
  final String link;
  final String thumbnail;
  late double latitude;
  late double longitude;

  Event({
    required this.title,
    required this.date,
    required this.address,
    required this.link,
    required this.thumbnail,
  });

  setCoordinates(Location location) {
    latitude = location.latitude;
    longitude = location.longitude;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: EventDate.fromJson(json['date']),
      address: List<String>.from(json['address']),
      link: json['link'],
      thumbnail: json['thumbnail'],
    );
  }

  @override
  String toString() {
    return 'Event{\n'
        '  title: $title,\n'
        '  date: ${date.toString()},\n'
        '  address: $address,\n'
        '  link: $link,\n'
        '  thumbnail: $thumbnail,\n'
        '  latitude: $latitude,\n'
        '  longitude: $longitude\n'
        '}';
  }
}
