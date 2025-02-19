import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool isReadOnly;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;
  final VoidCallback? onPasswordVisibilityChanged;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.focusNode,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isPasswordVisible = false,
    this.onPasswordVisibilityChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: isPassword ? isPasswordVisible : false,
      readOnly: isReadOnly,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withAlpha(51),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: onPasswordVisibilityChanged,
              )
            : null,
      ),
    );
  }
}
