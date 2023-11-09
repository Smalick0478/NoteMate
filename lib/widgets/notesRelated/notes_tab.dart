import 'package:notemate/providers/note_provider.dart';

import 'package:notemate/widgets/notesRelated/note_cards.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemate/widgets/notesRelated/notes_search.dart';

class NotesTab extends StatefulWidget {
  const NotesTab({
    super.key,
  });

  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          body: Consumer(builder: (context, ref, child) {
            final streamProv = ref.watch(notesProvider);
            return NoteCards(streamProv);
          }),
        ));
  }
}

// class NotesSearchTab extends StatefulWidget {
//   const NotesSearchTab({super.key});

//   @override
//   State<NotesSearchTab> createState() => _NotesSearchTabState();
// }

// class _NotesSearchTabState extends State<NotesSearchTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Scaffold(
//         body: Consumer(
//           builder: (context, ref, child) {
//             final searchQuery = ref.watch(searchQueryProvider).state;
//             final streamProv = ref.watch(notesSearchProvider(searchQuery));
//             return NoteSearch(streamProv);
//           },
//         ),
//       ),
//     );
//   }
// }

