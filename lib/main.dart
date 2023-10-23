import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notemate/screens/authentication/login_screen.dart';
import 'package:notemate/screens/authentication/signup_screen.dart';
import 'package:notemate/screens/functionalities/helpScreen.dart';
import 'package:notemate/screens/functionalities/home_page.dart';
import 'package:notemate/screens/functionalities/privacy_policy_screen.dart';
import 'package:notemate/screens/functionalities/settings.dart';
import 'package:notemate/screens/functionalities/terms_of_use_screen.dart';
import 'package:notemate/screens/wrapper.dart';
import 'package:notemate/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (details) {
    //whenever there's an error, exit the app
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(ProviderScope(
      child: DevicePreview(
          enabled: !kReleaseMode, builder: ((context) => MyApp()))));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      theme: CustomTheme.DarkTheme,
      home: const Wrapper(),
      routes: {
        'Login': (context) => const LoginScreen(),
        'Sign up': (context) => const SignUpScreen(),
        'Home page': (context) => const HomePage(),
        'Settings': (context) => const SettingsScreen(),
        'Help Screen': (context) => HelpScreen(),
        'Privacy Policy': (context) => PrivacyPolicyScreen(),
        'Terms & Conditions': (context) => TermsOfUseScreen(),
      },
    );
  }
}
