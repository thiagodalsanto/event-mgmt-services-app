import 'package:event_mgmt_services_app/providers/user_provider.dart';
import 'package:event_mgmt_services_app/routes/route_names.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_elevated_button.dart';
import 'package:event_mgmt_services_app/shared/components/buttons/custom_text_button.dart';
import 'package:event_mgmt_services_app/shared/components/notifications/error_notification.dart';
import 'package:event_mgmt_services_app/shared/components/notifications/success_notifications.dart';
import 'package:event_mgmt_services_app/shared/components/textfields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool _isPasswordVisible = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _senhaFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.isLoggedIn == true) {
      Future.microtask(() {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.home);
        }
      });
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _senhaFocusNode.dispose();
    super.dispose();
  }

  void _loginUser() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      await userProvider.loginUser(emailController.text, senhaController.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.home);
      showSuccessNotification(context, "Login efetuado com sucesso!");
    } catch (e) {
      if (!mounted) return;
      showErrorNotification(context, "Erro ao efetuar login!");
    }
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.event,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bem-vindo ao Event App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: emailController,
                  label: "E-mail",
                  icon: Icons.email,
                  isPassword: false,
                  focusNode: _emailFocusNode,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: senhaController,
                  label: "Senha",
                  icon: Icons.lock,
                  focusNode: _senhaFocusNode,
                  isPassword: true,
                  isPasswordVisible: !_isPasswordVisible,
                  onPasswordVisibilityChanged: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: "Entrar",
                  onPressed: _loginUser,
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF2575FC),
                ),
                const SizedBox(height: 15),
                CustomTextButton(
                  text: "Criar uma conta",
                  onPressed: () {
                    _emailFocusNode.unfocus();
                    _senhaFocusNode.unfocus();
                    Navigator.pushNamed(context, RouteNames.register);
                  },
                  textColor: Colors.white,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
