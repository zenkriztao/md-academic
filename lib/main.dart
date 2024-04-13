import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/firebase_options.dart';
import 'package:academic/services/reminder.dart';
import 'package:academic/services/setup_hive.dart';
import 'package:academic/views/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'controllers/authentication_controller.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await setupHive();
  ReminderService.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: OnboardingScreen(),
      ),
    );
  }
}
