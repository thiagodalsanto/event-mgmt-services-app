String? validatePassword(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'A senha não pode estar vazia';
  }
  if (value.length < 6) {
    return 'A senha precisa ter 6 dígitos ou mais';
  }
  if (value == password) {
    return 'A nova senha deve ser diferente da senha atual';
  }
  return null;
}

String? validateConfirmPassword(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'A confirmação da senha não pode estar vazia';
  }
  if (value.length < 6) {
    return 'A confirmação da senha precisa ter 6 dígitos ou mais';
  }
  if (value != password) {
    return 'As senhas não coincidem';
  }
  return null;
}
