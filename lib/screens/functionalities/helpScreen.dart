import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notemate/utils/colors.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextEditingController messageController = TextEditingController();

  String type = "Feedback";

  suggestFeebback(
    String emailId,
  ) async {
    await FirebaseFirestore.instance
        .collection('feedbacks')
        .doc(emailId)
        .collection('feedbacks')
        .add({
      'message': messageController.text,
      'email': emailId,
      'type': type,
    });
    CustomSnackBarColored.show(
      context,
      'Success',
      'Your Feedback Has Been Sent',
      const Duration(seconds: 3),
      CustomTheme.successColor, // Specify the background color
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Help & Support",
          style: TextStyle(fontFamily: "Open", fontSize: 15),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.live_help_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 10, 10),
              child: Text(
                'Reach us',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: "open",
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(
                      fontFamily: "Open", fontSize: 14.5, color: Colors.white),
                  children: [
                    TextSpan(
                      text:
                          "Your feedback is important to us in order to make NoteMate a better and safer place for everyone.",
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
              child: DropdownButtonFormField(
                isExpanded: true,
                value: type,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: [
                  'Feedback',
                  'Complaints',
                  "Suggestions (Features / Fix bugs)"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    type = value.toString();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
              child: TextFormField(
                controller: messageController,
                maxLines: 6,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Enter your message here',
                    hintStyle: const TextStyle(
                        fontFamily: "open", color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
              child: TextFormField(
                initialValue: FirebaseAuth.instance.currentUser!.email,
                style: TextStyle(color: Colors.white),
                readOnly: true,
                decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontFamily: "Open", color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(200, 50),
                ),
                onPressed: () async {
                  await suggestFeebback(
                      FirebaseAuth.instance.currentUser!.email!);
                },
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(
                      fontFamily: "Open",
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
