import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/map/domain/repos/map_repo.dart';

class FirebaseMapRepo implements MapRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<List<EventModel>> getAllEvents() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('events')
          .where(
            'date',
            isGreaterThanOrEqualTo: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).millisecondsSinceEpoch,
          )
          .orderBy('date', descending: false)
          .get();

      final events = snapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data()).copyWith(uId: doc.id);
      }).toList();

      return events; // If there is no events the function will return []
    } catch (e) {
      debugPrint('failed fetching events: ${e.toString()}');
    }
    return [];
  }
}
