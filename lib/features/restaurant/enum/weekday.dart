enum Weekday {
  monday(0, "Monday"),
  tuesday(1, "Tuesday"),
  wednesday(2, "Wednesday"),
  thursday(3, "Thursday"),
  friday(4, "Friday"),
  saturday(5, "Saturday"),
  sunday(6, "Sunday");

  final int dayNumber;
  final String name;

  const Weekday(this.dayNumber, this.name);

  static Weekday fromIndex(int dayNumber) {
    return Weekday.values
        .firstWhere((element) => element.dayNumber == dayNumber);
  }
}
