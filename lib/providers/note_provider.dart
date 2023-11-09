import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemate/screens/functionalities/home_page.dart';

final notesProvider = StreamProvider(((ref) => FirebaseFirestore.instance
    .collection(AuthService().useUid)
    .orderBy('date', descending: true)
    .snapshots()));// Define a StateNotifier for searchQuery

// final notesProvider =
//     StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
//   final query = ref.watch(searchQueryProvider);
//   return FirebaseFirestore.instance
//       .collection(AuthService().useUid)
//       .orderBy('date', descending: true)
//       .where('title', isGreaterThanOrEqualTo: query)
//       .snapshots();
// });
