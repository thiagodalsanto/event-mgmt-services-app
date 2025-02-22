// ignore_for_file: avoid_print
import 'package:event_mgmt_services_app/providers/event_provider.dart';
import 'package:event_mgmt_services_app/providers/user_provider.dart';
import 'package:event_mgmt_services_app/routes/app_routes.dart';
import 'package:event_mgmt_services_app/view/home_page.dart';
import 'package:event_mgmt_services_app/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('users');
  await Hive.openBox('cache');

  final userProvider = UserProvider();
  await userProvider.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userProvider),
        ChangeNotifierProvider(create: (context) => EventProvider())
      ],
      child: MyApp(isUserLoggedIn: userProvider.isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({super.key, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: !isUserLoggedIn ? const LoginPage() : const HomePage(),
    );
  }
}
