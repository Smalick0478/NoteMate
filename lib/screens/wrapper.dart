import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:notemate/screens/authentication/introduction_screen.dart';
import 'package:notemate/screens/errorAndLoading/error_screen.dart';
import 'package:notemate/screens/functionalities/home_page.dart';
import 'package:notemate/screens/errorAndLoading/loading_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (AuthService().isVerified) {
                return HomePage();
              } else if (snapshot.hasError) {
                return ErrorPage();
              }
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          return const IntroductionScreen();
        }));
  }
}
