import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FetchPollsProvider extends ChangeNotifier {
  List<DocumentSnapshot> _pollsList = <DocumentSnapshot<Object?>>[];
  List<DocumentSnapshot> _usersPollsList = <DocumentSnapshot<Object?>>[];

  DocumentSnapshot? _individualPoll;

  bool _isLoading = true;

  ///
  bool get isLoading => _isLoading;

  List<DocumentSnapshot> get pollsList => _pollsList;
  List<DocumentSnapshot> get userPollsList => _usersPollsList;

  DocumentSnapshot get individualPolls => _individualPoll!;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference pollCollection =
  FirebaseFirestore.instance.collection('polls');

  ///Fetch all polls
  Future<void> fetchAllPolls() async {
    await pollCollection.get().then((value) {
      if (value.docs.isEmpty) {
        _pollsList = <DocumentSnapshot<Object?>>[];
        _isLoading = false;
        notifyListeners();
      } else {
        final List<QueryDocumentSnapshot<Object?>> data = value.docs;

        _pollsList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  ///Fetch user polls
  Future<void> fetchUserPolls() async {
    await pollCollection.where('authorId', isEqualTo: user!.uid).get().then((value) {
      print(user!.uid);
      // print(value.docs[0].data());
      if (value.docs.isEmpty) {
        _usersPollsList.clear();
        _isLoading = false;
        notifyListeners();
      } else {
        final List<QueryDocumentSnapshot<Object?>> data = value.docs;

        _usersPollsList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  ///fetch individual polls
  Future<void> fetchIndividualPolls(String id) async {
    await pollCollection.doc(id).get().then((value) {
      if (!value.exists) {
        _individualPoll = value;
        _isLoading = false;
        notifyListeners();
      } else {
        final DocumentSnapshot<Object?> data = value;

        _individualPoll = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}