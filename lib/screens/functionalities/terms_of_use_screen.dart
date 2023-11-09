import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  TermsOfUseScreen({super.key});

  final normalTextStyle = TextStyle(
      color: Colors.grey.shade700, fontSize: 13.6, fontFamily: "Open");
  final divider = const SizedBox(height: 10);
  final headingTextStyle = const TextStyle(
      color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Open",
              ),
            ),
            Text(
              "Effective Date : October 25, 2023",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontFamily: "Open",
              ),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Terms and Conditions:\n\nWelcome to NoteMate! By using our app, you agree to these Terms and Conditions. Please read them carefully before using our services.'
                          '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Acceptance of Terms:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' By using the NoteMate app, you agree to abide by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the app.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Internet Connectivity:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate requires an internet connection to function. You are responsible for any data charges incurred while using the app.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Image Upload:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate may require access to your device\'s storage to upload images. We do not use or collect images without your permission.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'User Data Collection:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate respects your privacy. We do not collect any data without your consent. Any data you provide, such as personal information or job details, is used solely for the purpose of providing our services.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Data Usage:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate does not share user data with marketing or advertisement agencies. Your data remains confidential and is used only for app functionality.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'User Suspension:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate reserves the right to suspend or remove users who violate our terms of use or engage in illegal activities. Users will be notified of such actions.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Illegal Usage:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' Using NoteMate for illegal purposes is strictly prohibited. Any user found engaging in illegal activities will face legal action.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Support and Queries:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' For assistance and queries, you can contact our support team through the in-app support feature. We are committed to making NoteMate a safe and reliable platform for all users.',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Changes to Terms:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          ' NoteMate reserves the right to modify these Terms and Conditions at any time. Users will be notified of any changes, and continued use of the app signifies your acceptance of the revised terms.'
                          '\n\nBy using the NoteMate app, you agree to these Terms and Conditions. Thank you for choosing NoteMate!'
                          '\n\n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              divider,
            ],
          ),
        ),
      ),
    );
  }
}
