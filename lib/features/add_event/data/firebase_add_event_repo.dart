import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maw3ed/features/add_event/domain/entities/event_model.dart';
import 'package:maw3ed/features/add_event/domain/repos/add_event_repo.dart';

class FirebaseAddEventRepo extends AddEventRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addEvent(EventModel newEvent) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .add(newEvent.toMap());
    } catch (e) {
      print("Error adding event: $e");
      throw Exception("Error adding event: $e");
    }
  }
}
