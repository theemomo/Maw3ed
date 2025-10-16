import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:maw3ed/features/add_event/domain/entities/event_model.dart';
import 'package:maw3ed/features/home/domain/repos/home_repo.dart';

class FirebaseHomeRepo implements HomeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<List<EventModel>> getTodayEvents() async {
    try {
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('events')
          .where('date', isEqualTo: today.millisecondsSinceEpoch)
          .get();

      final events = snapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data());
      }).toList();

      return events; // If there is no events the function will return []
    } catch (e) {
      debugPrint('failed fetching events: ${e.toString()}');
    }
    return [];
  }
}
