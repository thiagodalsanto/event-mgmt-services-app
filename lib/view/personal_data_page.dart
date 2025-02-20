// pages/personal_data_page.dart
import 'package:event_mgmt_services_app/providers/user_provider.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_elevated_button.dart';
import 'package:event_mgmt_services_app/shared/components/textfields/custom_text_field.dart';
import 'package:event_mgmt_services_app/shared/components/texts/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  PersonalDataPageState createState() => PersonalDataPageState();
}

class PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  bool _isPasswordVisible = false;

  void _loadUserData() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      nomeController.text = user.name;
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  const SectionTitle(title: "Nome"),
                  CustomTextField(
                    controller: nomeController,
                    label: "Nome Completo",
                    icon: Icons.person,
                    isPassword: false,
                    isReadOnly: true,
                    isPasswordVisible: _isPasswordVisible,
                    onPasswordVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const SectionTitle(title: "E-mail"),
                  CustomTextField(
                    controller: emailController,
                    label: "E-mail",
                    icon: Icons.email,
                    isPassword: false,
                    isReadOnly: true,
                    isPasswordVisible: _isPasswordVisible,
                    onPasswordVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const SectionTitle(title: "Alterar Senha"),
                  CustomTextField(
                    controller: senhaController,
                    label: "Nova Senha",
                    icon: Icons.lock,
                    isPassword: true,
                    isReadOnly: false,
                    isPasswordVisible: _isPasswordVisible,
                    onPasswordVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmarSenhaController,
                    label: "Confirmar Nova Senha",
                    icon: Icons.lock,
                    isPassword: true,
                    isReadOnly: false,
                    isPasswordVisible: _isPasswordVisible,
                    onPasswordVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Salvar",
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    textColor: const Color(0xFF2575FC),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 20),
        const Text(
          "Dados Pessoais",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
