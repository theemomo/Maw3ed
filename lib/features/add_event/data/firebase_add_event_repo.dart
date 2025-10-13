import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maw3ed/features/add_event/domain/entities/add_event_model.dart';
import 'package:maw3ed/features/add_event/domain/repos/add_event_repo.dart';
import 'package:maw3ed/features/auth/data/firebase_auth_repo.dart';

class FirebaseAddEventRepo extends AddEventRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthRepo authRepo = FirebaseAuthRepo();
  @override
  Future<void> addEvent(AddEventModel newEvent) async {
    try {
      final user = await authRepo.getCurrentUser();
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('events')
          .add(newEvent.toMap());
    } catch (e) {
      print("Error adding event: $e");
    }
  }
}
