import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  String _message = '';

  bool _status = false;
  bool _deleteStatus = false;

  String get message => _message;
  bool get status => _status;
  bool get deleteStatus => _deleteStatus;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference pollCollection =
  FirebaseFirestore.instance.collection('polls');

  Future<void> addPoll(
      {required String question,
        required String duration,
        required List<Map> options}) async {
    _status = true;
    notifyListeners();
    try {
      ///
      final Map<String, Object> data = <String, Object>{
        'authorId': user!.uid,
        'author': <String, String?>{
          'uid': user!.uid,
          'profileImage': user!.photoURL,
          'name': user!.displayName,
        },
        'dateCreated': DateTime.now(),
        'poll': <String, Object>{
          'total_votes': 0,
          'voters': <Map>[],
          'question': question,
          'duration': duration,
          'options': options,
        }
      };

      await pollCollection.add(data);
      _message = 'Poll Created';
      _status = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _status = false;
      notifyListeners();
    } catch (e) {
      _message = 'Please try again...';
      _status = false;
      notifyListeners();
    }
  }

  Future<void> deletePoll({required String pollId}) async {
    _deleteStatus = true;
    notifyListeners();

    try {
      await pollCollection.doc(pollId).delete();
      _message = 'Poll Deleted';
      _deleteStatus = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _deleteStatus = false;
      notifyListeners();
    } catch (e) {
      _message = 'Please try again...';
      _deleteStatus = false;
      notifyListeners();
    }
  }

  Future<void> votePoll(
      {required String? pollId,
        required DocumentSnapshot pollData,
        required int previousTotalVotes,
        required String seletedOptions}) async {
    _status = true;
    notifyListeners();

    try {
      final List voters = pollData['poll']['voters'];

      voters.add(<String, String?>{
        'name': user!.displayName,
        'uid': user!.uid,
        'selected_option': seletedOptions,
      });

      ///Create option and add items
      ///options
      final List options = pollData['poll']['options'];
      for (final i in options) {
        if (i['answer'] == seletedOptions) {
          i['percent']++;
        } else {
          if (i['percent'] > 0) {
            i['percent']--;
          }
        }
      }

      ///Update poll
      final data = {
        'author': {
          'uid': pollData['author']['uid'],
          'profileImage': pollData['author']['profileImage'],
          'name': pollData['author']['name'],
        },
        'dateCreated': pollData['dateCreated'],
        'poll': {
          'total_votes': previousTotalVotes + 1,
          'voters': voters,
          'question': pollData['poll']['question'],
          'duration': pollData['poll']['duration'],
          'options': options,
        }
      };

      await pollCollection.doc(pollId).update(data);
      _message = 'Vote Recorded';
      _status = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _message = e.message!;
      _status = false;
      notifyListeners();
    } catch (e) {
      _message = 'Please try again...';
      _status = false;
      notifyListeners();
    }
  }

  void clear() {
    _message = '';
    notifyListeners();
  }
}