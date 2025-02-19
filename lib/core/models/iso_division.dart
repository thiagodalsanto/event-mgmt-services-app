class IsoDivision {
  final String code;
  final String name;

  IsoDivision({required this.code, required this.name});

  factory IsoDivision.fromJson(String code, String name) {
    return IsoDivision(code: code, name: name);
  }
}
