import 'package:calendar_mgmt_services_app/res/theme/theme_manager.dart';
import 'package:calendar_mgmt_services_app/res/theme/themes.dart';
import 'package:calendar_mgmt_services_app/view/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeManager(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeManager.themeMode,
      home: const MyHomePage(title: 'Demo Home Page'),
    );
  }
}
