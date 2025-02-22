import 'package:event_mgmt_services_app/shared/components/textfields/custom_text_field.dart';
import 'package:event_mgmt_services_app/shared/components/texts/section_title.dart';
import 'package:flutter/material.dart';

class PersonalDataForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function() onPasswordVisibilityChanged;
  final bool isPasswordVisible;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validatorPassword;
  final String? Function(String?)? validatorConfirmPassword;

  const PersonalDataForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onPasswordVisibilityChanged,
    required this.isPasswordVisible,
    required this.formKey,
    required this.validatorPassword,
    required this.validatorConfirmPassword,
  });

  @override
  State<PersonalDataForm> createState() => PersonalDataFormState();
}

class PersonalDataFormState extends State<PersonalDataForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          const SectionTitle(title: "Nome"),
          CustomTextField(
            controller: widget.nameController,
            label: 'Nome completo',
            icon: Icons.person,
            isPassword: false,
            isReadOnly: true,
          ),
          const SizedBox(height: 20),
          const SectionTitle(title: "E-mail"),
          CustomTextField(
            controller: widget.emailController,
            label: 'Email',
            icon: Icons.email,
            isPassword: false,
            isReadOnly: true,
          ),
          const SizedBox(height: 20),
          const SectionTitle(title: "Alterar Senha"),
          CustomTextField(
            controller: widget.passwordController,
            label: 'Nova senha',
            icon: Icons.lock,
            isPassword: true,
            isReadOnly: false,
            isPasswordVisible: widget.isPasswordVisible,
            onPasswordVisibilityChanged: widget.onPasswordVisibilityChanged,
            validator: widget.validatorPassword,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: widget.confirmPasswordController,
            label: 'Confirmar nova senha',
            icon: Icons.lock,
            isPassword: true,
            isReadOnly: false,
            isPasswordVisible: widget.isPasswordVisible,
            onPasswordVisibilityChanged: widget.onPasswordVisibilityChanged,
            validator: widget.validatorConfirmPassword,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
