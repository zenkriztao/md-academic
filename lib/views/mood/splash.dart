/*import 'package:flutter/material.dart';
import 'package:academic/controllers/settings_controller.dart';
import 'package:academic/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool shouldProceed = false;

  _fetchPrefs() async {
    await SettingsController.initializeTheme();

    setState(() {
      shouldProceed = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return shouldProceed ? const Home() : const SizedBox.shrink();
  }
}
*/