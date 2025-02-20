import 'package:flutter/foundation.dart';
import 'package:calendar_mgmt_services_app/features/event/models/event.dart';

class EventProvider extends ChangeNotifier {
  Event? _selectedEvent;

  Event? get selectedEvent => _selectedEvent;

  void setSelectedEvent(Event event) {
    _selectedEvent = event;
    notifyListeners();
  }
}
