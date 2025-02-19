import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class LocationSearchBar extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;

  const LocationSearchBar({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      controller: controller,
      label: 'Buscar eventos por localização...',
      icon: Icons.location_on,
      isPassword: false,
    );
  }
}
