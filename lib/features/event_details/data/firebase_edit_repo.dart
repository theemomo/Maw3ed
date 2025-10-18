import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/event_details/domain/repos/edit_event_repo.dart';

class FirebaseEditRepo implements EditEventRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<void> deleteEvent(EventModel event) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('events')
          .doc(event.uId)
          .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> editEvent(EventModel event) async {}
}
