import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notemate/resources/firestore_methods.dart';
import 'package:notemate/screens/errorAndLoading/error_screen.dart';
import 'package:notemate/screens/errorAndLoading/loading_screen.dart';
import 'package:notemate/utils/colors.dart';
import 'package:notemate/widgets/notesRelated/custom_app_bar.dart';
import 'package:notemate/widgets/notesRelated/note_header.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditNote extends ConsumerStatefulWidget {
  final String noteUid;
  const EditNote({Key? key, required this.noteUid}) : super(key: key);

  @override
  EditNoteState createState() => EditNoteState();
}

class EditNoteState extends ConsumerState<EditNote> {
  late final futureNote = FutureProvider(
      ((ref) => FirestoreService().getNote(uid: widget.noteUid)));
  ValueNotifier<String?> selected = ValueNotifier(null);
  late TextEditingController _titleController;
  late editor.QuillController _controller;
  bool showEditor = false;

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(futureNote).when(
        error: ((error, stackTrace) => ErrorPage()),
        loading: (() => LoadingScreen()),
        data: ((data) {
          _titleController = TextEditingController(text: data['title']);
          selected.value = data['folder'];
          final previousFolder = data['folder'];
          _controller = editor.QuillController(
              document: editor.Document.fromJson(jsonDecode(data['document'])),
              selection: const TextSelection.collapsed(offset: 0));
          return SafeArea(
              child: Scaffold(
                  body: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  CustomAppBar(
                      noteuid: widget.noteUid,
                      folderNoteuid: selected.value,
                      onPressed: () async {
                        String json =
                            jsonEncode(_controller.document.toDelta().toJson());
                        String plainText =
                            jsonEncode(_controller.document.toPlainText());
                        await FirestoreService()
                            .updateDocument(
                                previousFolder: previousFolder,
                                folder: selected.value,
                                searchableDocument: plainText,
                                document: json,
                                title: _titleController.text,
                                noteUid: widget.noteUid,
                                date: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            CustomSnackBar.show(
                                context, '$value', Duration(seconds: 2));
                          }
                          Navigator.of(context).pop();
                          CustomSnackBarColored.show(
                            context,
                            'Success',
                            'Note Updated Successfully',
                            const Duration(seconds: 3),
                            CustomTheme
                                .successColor, // Specify the background color
                          );
                        });
                      }),
                  NoteHeader(
                      editNoteMod: true,
                      titleController: _titleController,
                      selected: selected,
                      snapshot: data),
                  SizedBox(
                    height: 5,
                  ),
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
                    showBoldButton: false,
                  )
                ],
              ),
            )
          ])));
        }));
  }
}
