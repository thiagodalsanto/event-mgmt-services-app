class LocationDisabledException implements Exception {
  final String message;
  LocationDisabledException(this.message);
  @override
  String toString() => message;
}
