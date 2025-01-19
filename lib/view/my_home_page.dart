import 'package:calendar_mgmt_services_app/res/i18n/translations.dart';
import 'package:calendar_mgmt_services_app/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isEnglish = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
      Translations.load(Locale(_isEnglish ? 'en_US' : 'pt_BR'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Translations.string.pushedButtonText,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _toggleLanguage,
              child: Text(
                style: Theme.of(context).textTheme.bodySmall,
                _isEnglish ? 'Switch to Portuguese' : 'Mudar para Inglês',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                themeManager.toggleTheme(themeManager.themeMode == ThemeMode.light);
              },
              child: Text(
                style: Theme.of(context).textTheme.bodySmall,
                themeManager.themeMode == ThemeMode.light
                    ? 'Switch to Dark Mode'
                    : 'Switch to Light Mode',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
