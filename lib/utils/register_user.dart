import 'package:event_mgmt_services_app/models/user_model.dart';
import 'package:event_mgmt_services_app/shared/components/notifications/error_notification.dart';
import 'package:event_mgmt_services_app/shared/components/notifications/success_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

Future registerUser(context, formKey, emailController, nameController, passwordController) async {
  if (formKey.currentState!.validate()) {
    final usersBox = Hive.box('users');
    final email = emailController.text;

    final userExists = usersBox.containsKey(email);

    if (userExists) {
      showErrorNotification(context, "Email já cadastrado!");
      return;
    }

    final newUser = User(
      name: nameController.text,
      email: email,
      password: passwordController.text,
    );

    await usersBox.put(email, newUser.toMap());

    if (!context.mounted) return;

    showSuccessNotification(context, "Usuário cadastrado com sucesso!");

    Navigator.pop(context);
  }
}
