import 'package:flutter/material.dart';
import 'package:notemate/utils/colors.dart';

class CustomSnackBar {
  final String message;
  final Duration duration;
  CustomSnackBar({required this.message, required this.duration});

  static show(BuildContext context, String message, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).cardColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        content: Text(message)));
  }
}

// class CustomSnackBarColored {
//   final String message;
//   final Duration duration;
//   CustomSnackBarColored({required this.message, required this.duration});

//   static show(
//     BuildContext context,
//     String message,
//     Duration duration,
//   ) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: CustomTheme.dangerColor,
//         behavior: SnackBarBehavior.floating,
//         duration: duration,
//         content: Text(message)));
//   }
// }
class CustomSnackBarColored {
  final String title;
  final String description;
  final Duration duration;
  final Color? backgroundColor; // Add backgroundColor field

  CustomSnackBarColored({
    required this.title,
    required this.description,
    required this.duration,
    this.backgroundColor, // Include backgroundColor in the constructor
  });

  static show(BuildContext context, String title, String description,
      Duration duration, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          Text(
            description,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ));
  }
}
