import 'package:event_mgmt_services_app/shared/components/buttons/custom_elevated_button.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_text_button.dart';
import 'package:event_mgmt_services_app/shared/components/forms/register_form.dart';
import 'package:event_mgmt_services_app/shared/components/headers/register_header.dart';
import 'package:event_mgmt_services_app/utils/register_user.dart';
import 'package:event_mgmt_services_app/utils/register_validations.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _nameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegisterHeader(title: 'Crie sua conta'),
                  const SizedBox(height: 30),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordVisible,
                    builder: (context, isPasswordVisible, child) {
                      return RegisterForm(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        formKey: _formKeyRegister,
                        validatePassword: (value) => validatePassword(passwordController.text),
                        validateConfirmPassword: (value) =>
                            validateConfirmPassword(value, confirmPasswordController.text),
                        validateEmail: (value) => validateEmail(emailController.text),
                        validateName: (value) => validateField(value, nameController.text),
                        nameFocusNode: _nameFocusNode,
                        emailFocusNode: _emailFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        confirmPasswordFocusNode: _confirmPasswordFocusNode,
                        isPasswordVisible: isPasswordVisible,
                        onPasswordVisibilityChanged: () {
                          _isPasswordVisible.value = !_isPasswordVisible.value;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    text: "Cadastrar",
                    onPressed: () async {
                      await registerUser(
                          context, _formKeyRegister, emailController, nameController, passwordController);
                    },
                    backgroundColor: Colors.white,
                    textColor: const Color(0xFF2C3E50),
                  ),
                  const SizedBox(height: 15),
                  CustomTextButton(
                    text: "Já tem uma conta? Faça login",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: Colors.white,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
