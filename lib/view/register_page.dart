import 'package:event_mgmt_services_app/models/user_model.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_elevated_button.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_text_button.dart';
import 'package:event_mgmt_services_app/shared/components/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  final FocusNode _nomeFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _senhaFocusNode = FocusNode();
  final FocusNode _confirmarSenhaFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _nomeFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _senhaFocusNode.unfocus();
    _confirmarSenhaFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nomeFocusNode.dispose();
    _emailFocusNode.dispose();
    _senhaFocusNode.dispose();
    _confirmarSenhaFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um e-mail';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }
    if (value != senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira $fieldName';
    }
    return null;
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final usersBox = Hive.box('users');
      final email = emailController.text;

      final userExists = usersBox.containsKey(email);

      if (userExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Este e-mail já está em uso')),
        );
        return;
      }

      final newUser = User(
        name: nomeController.text,
        email: email,
        password: senhaController.text,
      );

      await usersBox.put(email, newUser.toMap());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro realizado com sucesso!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person_add,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Crie sua Conta",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: nomeController,
                      label: "Nome Completo",
                      icon: Icons.person,
                      isPassword: false,
                      focusNode: _nomeFocusNode,
                      validator: (value) => _validateField(value, 'seu nome'),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: emailController,
                      label: "E-mail",
                      icon: Icons.email,
                      isPassword: false,
                      focusNode: _emailFocusNode,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: senhaController,
                      label: "Senha",
                      icon: Icons.lock,
                      focusNode: _senhaFocusNode,
                      validator: _validatePassword,
                      isPassword: true,
                      isPasswordVisible: _isPasswordVisible,
                      onPasswordVisibilityChanged: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: confirmarSenhaController,
                      label: "Confirmar Senha",
                      icon: Icons.lock,
                      focusNode: _confirmarSenhaFocusNode,
                      validator: _validateConfirmPassword,
                      isPassword: true,
                      isPasswordVisible: _isPasswordVisible,
                      onPasswordVisibilityChanged: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      text: "Cadastrar",
                      onPressed: _registerUser,
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF2575FC),
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
      ),
    );
  }
}
