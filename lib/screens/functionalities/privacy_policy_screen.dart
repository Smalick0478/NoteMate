import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final normalTextStyle = TextStyle(
      color: Colors.grey.shade700, fontSize: 14.6, fontFamily: "Open");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy Policy",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'At NoteMate, your privacy is important to us. This Privacy Policy outlines how we collect, use, and protect your personal information.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Data Collection:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' NoteMate collects the information you provide when using the app, such as your name, email. We use this information to provide our services and improve your experience.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Content Stored:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' NoteMate is designed for the storage of various daily life items, to-do lists, and other personal notes. Users are advised not to store sensitive or personal information, including but not limited to account credentials or any data that could be used to link back to your personal accounts. NoteMate will not be held responsible for the security of such information.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Third-Party Advertisements:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' NoteMate may feature third-party advertisements within the application. These advertisements are not under our direct control, and we do not endorse or take responsibility for the content or privacy practices of these third-party advertisers. It is advisable to review the privacy policies of these third-party providers.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Unauthorized Access:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' Any unauthorized access to NoteMate without our consent will be subject to legal procedures.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Security:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' While we take reasonable measures to protect your personal information from unauthorized access or disclosure, it is essential to note that no method of transmission over the internet is completely secure.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Data Usage:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' Your data is used solely for the purpose of app functionality, including storing and accessing your notes. We do not share your data with marketing or advertisement agencies.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Bug Reports:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' If you identify any bugs or vulnerabilities within NoteMate, please report them to our Help Center within the app.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Changes to Privacy Policy:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' NoteMate may periodically update this Privacy Policy. Any revisions will be communicated to users, and your continued use of the app signifies your acceptance of the updated policy.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        'Contact Us:\n\nIf you have any questions or concerns regarding this Privacy Policy, please contact us.'
                        '\n\nYour trust is important to us, and we are committed to protecting your privacy. Thank you for choosing NoteMate!',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
