import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:notemate/resources/internet_connection.dart';
import 'package:notemate/screens/errorAndLoading/empty_result.dart';
import 'package:notemate/screens/errorAndLoading/error_screen.dart';
import 'package:notemate/screens/errorAndLoading/loading_screen.dart';
import 'package:notemate/screens/functionalities/edit_note.dart';
import 'package:notemate/widgets/reusedComponents/animation_transition.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class LiveSearchScreen extends StatefulWidget {
  const LiveSearchScreen({
    super.key,
  });
  @override
  _LiveSearchScreenState createState() => _LiveSearchScreenState();
}

class _LiveSearchScreenState extends State<LiveSearchScreen> {
  String? query = '';
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection(AuthService().useUid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          tooltip: 'Go Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 50), // Add "top" padding
            child: Text(
              'Search Notes',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32 // Set the text color to white
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Notes',
                prefixIcon: Icon(Icons.search),
              ),
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: query == ''
                  ? notesCollection
                      .orderBy('date', descending: true)
                      .snapshots()
                  : notesCollection
                      .where('title', isEqualTo: query)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                if (snapshot.hasError) {
                  return ErrorPage();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return EmptyResult();
                }

                return MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  itemCount: query!.isNotEmpty ? 1 : snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var myData = query!.isEmpty
                        ? snapshot.data!.docs[index]
                        : snapshot.data!.docs.first;
                    var json = jsonDecode(myData['document']);
                    final controller = quill.QuillController(
                      document: quill.Document.fromJson(json),
                      selection: const TextSelection.collapsed(offset: 0),
                    );
                    final uid = myData.id;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(FadeTrans(
                          translateTo: EditNote(noteUid: uid),
                        ));
                      },
                      child: Builder(builder: (context) {
                        final title = myData['title'] ?? 'No Title';
                        final date = myData['date']?.toDate() ?? DateTime.now();
                        final folder = myData['folder'] ?? 'No Folder';

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 22,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              AutoSizeText(
                                title,
                                minFontSize: 16,
                                maxLines: 4,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ShaderMask(
                                shaderCallback: ((bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(189, 218, 218, 252),
                                      Color.fromARGB(189, 218, 218, 252),
                                      Colors.transparent,
                                    ],
                                  ).createShader(bounds);
                                }),
                                child: quill.QuillEditor(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  autoFocus: true,
                                  enableInteractiveSelection: false,
                                  readOnly: true,
                                  showCursor: false,
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                  scrollable: true,
                                  expands: false,
                                  maxHeight: 150,
                                  scrollController: ScrollController(
                                    keepScrollOffset: false,
                                  ),
                                  controller: controller,
                                  focusNode: FocusNode(),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    Jiffy(date).MMMd.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          90, 255, 255, 255),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  SizedBox(
                                    width: 85,
                                    child: Text(
                                      folder,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: const Color.fromARGB(
                                            90, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
