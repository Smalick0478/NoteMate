import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notemate/resources/firestore_methods.dart';
import 'package:notemate/utils/colors.dart';
import 'package:notemate/widgets/notesRelated/custom_app_bar.dart';
import 'package:notemate/widgets/notesRelated/note_header.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final editor.QuillController _controller = editor.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  ValueNotifier<String> selected = ValueNotifier('All');

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
              child: Column(
            children: [
              CustomAppBar(onPressed: () async {
                String json =
                    jsonEncode(_controller.document.toDelta().toJson());
                String plainText =
                    jsonEncode(_controller.document.toPlainText());
                await FirestoreService()
                    .addDocument(
                        document: json,
                        searchableDocument: plainText,
                        title: _titleController.text,
                        folder: selected.value,
                        date: DateTime.now())
                    .then((value) {
                  if (value != null) {
                    CustomSnackBar.show(
                        context, '$value', Duration(seconds: 2));
                  }
                  Navigator.pop(context);
                  CustomSnackBarColored.show(
                    context,
                    'Success',
                    'Note Added Successfully',
                    const Duration(seconds: 3),
                    CustomTheme.successColor, // Specify the background color
                  );
                });
              }),
              NoteHeader(
                  editNoteMod: false,
                  titleController: _titleController,
                  selected: selected,
                  snapshot: null),
              Expanded(
                child: editor.QuillEditor(
                    focusNode: FocusNode(),
                    scrollable: true,
                    autoFocus: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollController: ScrollController(),
                    expands: true,
                    controller: _controller,
                    readOnly: false),
              ),
              editor.QuillToolbar.basic(
                controller: _controller,
                multiRowsDisplay: false,
                showIndent: true,
                showSmallButton: false,
                dialogTheme: editor.QuillDialogTheme(
                    inputTextStyle: TextStyle(color: Colors.white),
                    labelTextStyle: TextStyle(color: Colors.white)),
                showLink: true,
                showDirection: false,
                showBackgroundColorButton: false,
                showRedo: true,
                showSearchButton: true,
                showFontSize: false,
                showAlignmentButtons: true,
                showCodeBlock: true,
                showFontFamily: false,
                showInlineCode: false,
              )
            ],
          ))
        ],
      ),
    ));
  }
}
