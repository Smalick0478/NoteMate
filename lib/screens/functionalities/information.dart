import 'package:flutter/material.dart';

class InformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FAQs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '1. Can we use NoteMate to store account credentials?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' No, we advise you not to store your personal credentials. If you want to store such information, please do so in a format that only you can understand.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '2. What is NoteMate?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' NoteMate is a cross-platform notes application that can be accessed through your browser and from your mobile.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '3. Does NoteMate have any bug reporting?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' Yes, we have a dedicated feedback, complaint, and suggestion in-app that can be accessed through the help center.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '4. Does NoteMate store passwords in a database?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' No, NoteMate does not store your password, and your account can only be accessed by you.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '7. Seeking Help:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' If you require assistance, visit the Help Page and provide your suggestions on how we can assist you.'
                        '\n\n',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set border radius
                ),
                minimumSize: Size(150, 40), // Set the minimum width and height
                side: BorderSide.none, // Set the background color to green
              ),
              child: Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }
}
