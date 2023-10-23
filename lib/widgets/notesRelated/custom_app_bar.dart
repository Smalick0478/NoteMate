import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemate/models/note.dart';
import 'package:notemate/providers/note_provider.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:notemate/resources/firestore_methods.dart';
import 'package:notemate/utils/colors.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';

final firestoreService = FirestoreService();
final userUid = AuthService().useUid;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;
  final noteuid;
  final folderNoteuid;

  const CustomAppBar({
    required this.onPressed,
    this.noteuid,
    this.folderNoteuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
          height: 50,
          width: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 57, 56, 78))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        Expanded(child: SizedBox()),
        Container(
          margin: const EdgeInsets.only(right: 20, top: 30, bottom: 10),
          height: 50,
          width: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 243, 79, 64))),
              onPressed: () async {
                await firestoreService.deleteNote(
                    uid: noteuid, folder: folderNoteuid);

                Navigator.of(context).pop();
                CustomSnackBarColored.show(
                  context,
                  'Deleted',
                  'Note Deleted Successfully',
                  const Duration(seconds: 3),
                  CustomTheme.dangerColor, // Specify the background color
                );
              },
              child: const Text('Delete')),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, top: 30, bottom: 10),
          height: 50,
          width: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 57, 56, 78))),
              onPressed: onPressed,
              child: const Text('Save')),
        ),
      ],
    );
  }
}
