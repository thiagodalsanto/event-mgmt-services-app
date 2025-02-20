enum EventFilter {
  today("date:today", "Today's Events"),
  tomorrow("date:tomorrow", "Tomorrow's Events"),
  week("date:week", "This Week's Events"),
  weekend("date:weekend", "Today's Weekend's Events"),
  nextWeek("date:next_week", "Next Week's Events"),
  month("date:month", "This Month's Events"),
  nextMonth("date:next_month", "Next Month's Events"),
  virtualEvent("event_type:Virtual-Event", "Online Events");

  final String value; 
  final String description;

  const EventFilter(this.value, this.description);

  static EventFilter? fromValue(String value) {
    return EventFilter.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError("Invalid event filter: $value"),
    );
  }
}
