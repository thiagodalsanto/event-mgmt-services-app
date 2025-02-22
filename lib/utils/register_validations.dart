String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira um e-mail';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Por favor, insira um e-mail válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira uma senha';
  }
  if (value.length < 6) {
    return 'A senha deve ter pelo menos 6 caracteres';
  }
  return null;
}

String? validateConfirmPassword(String? value, senhaController) {
  if (value == null || value.isEmpty) {
    return 'Por favor, confirme sua senha';
  }
  if (value != senhaController.text) {
    return 'As senhas não coincidem';
  }
  return null;
}

String? validateField(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira o nome';
  }
  return null;
}
