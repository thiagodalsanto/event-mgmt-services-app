// pages/personal_data_page.dart
import 'package:event_mgmt_services_app/providers/user_provider.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_elevated_button.dart';
import 'package:event_mgmt_services_app/shared/components/forms/personal_data_form.dart';
import 'package:event_mgmt_services_app/shared/components/headers/personal_data_header.dart';
import 'package:event_mgmt_services_app/utils/personal_data_validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  PersonalDataPageState createState() => PersonalDataPageState();
}

class PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _loadUserData() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
    }
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              PersonalDataHeader(title: "Dados Pessoais"),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: AnimatedBuilder(
                    animation: _isPasswordVisible,
                    builder: (context, child) => PersonalDataForm(
                      formKey: _formKey,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      isPasswordVisible: _isPasswordVisible.value,
                      onPasswordVisibilityChanged: () {
                        _isPasswordVisible.value = !_isPasswordVisible.value;
                      },
                      validatorPassword: (value) => validatePassword(value, user?.password),
                      validatorConfirmPassword: (value) => validateConfirmPassword(value, passwordController.text),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomButton(
                  text: "Salvar",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      userProvider.updateUser(
                        newPassword: passwordController.text,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
