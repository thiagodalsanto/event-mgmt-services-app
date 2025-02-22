import 'package:event_mgmt_services_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  UserProvider() {
    tryAutoLogin();
  }

  Future<void> tryAutoLogin() async {
    var box = await Hive.openBox('users');
    var cacheBox = await Hive.openBox('cache');

    final String? emailLogado = cacheBox.get('loggedUserEmail');

    if (emailLogado != null && box.containsKey(emailLogado)) {
      final userData = box.get(emailLogado);
      if (userData != null) {
        _user = User.fromMap(Map<String, dynamic>.from(userData as Map));
        notifyListeners();
        return;
      }
    }

    _user = null;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    var box = await Hive.openBox('users');
    var cacheBox = await Hive.openBox('cache');

    final userData = box.get(email);

    if (userData == null) {
      throw Exception("E-mail não cadastrado");
    }

    final userMap = Map<String, dynamic>.from(userData as Map);

    if (userMap['password'] != password) {
      throw Exception("Senha incorreta");
    }

    _user = User.fromMap(userMap);
    await cacheBox.put('loggedUserEmail', email);

    notifyListeners();
  }

  Future<void> logoutUser() async {
    var cacheBox = await Hive.openBox('cache');
    await cacheBox.delete('loggedUserEmail');

    _user = null;
    notifyListeners();
  }

  Future<void> updateUser({
    required String newPassword,
  }) async {
    if (_user == null) return;

    final updatedUser = User(
      name: _user!.name,
      email: _user!.email,
      password: newPassword.isNotEmpty ? newPassword : _user!.password,
    );

    _user = updatedUser;

    var box = await Hive.openBox('users');
    await box.put(updatedUser.email, updatedUser.toMap());

    notifyListeners();
  }
}
