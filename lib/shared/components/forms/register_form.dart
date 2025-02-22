import 'package:event_mgmt_services_app/shared/components/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function() onPasswordVisibilityChanged;
  final bool isPasswordVisible;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validatePassword;
  final String? Function(String?)? validateConfirmPassword;
  final String? Function(String?)? validateEmail;
  final String? Function(String?)? validateName;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onPasswordVisibilityChanged,
    required this.isPasswordVisible,
    required this.formKey,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.validateEmail,
    required this.validateName,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  });

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: widget.nameController,
            label: "Nome Completo",
            icon: Icons.person,
            focusNode: widget.nameFocusNode,
            validator: widget.validateName,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.emailController,
            label: "E-mail",
            icon: Icons.email,
            focusNode: widget.emailFocusNode,
            validator: widget.validateEmail,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.passwordController,
            label: "Senha",
            icon: Icons.lock,
            focusNode: widget.passwordFocusNode,
            validator: widget.validatePassword,
            isPassword: true,
            isPasswordVisible: widget.isPasswordVisible,
            onPasswordVisibilityChanged: widget.onPasswordVisibilityChanged,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.confirmPasswordController,
            label: "Confirmar Senha",
            icon: Icons.lock,
            focusNode: widget.confirmPasswordFocusNode,
            validator: widget.validateConfirmPassword,
            isPassword: true,
            isPasswordVisible: widget.isPasswordVisible,
            onPasswordVisibilityChanged: widget.onPasswordVisibilityChanged,
          ),
        ],
      ),
    );
  }
}
