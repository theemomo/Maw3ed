import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EventModel {
  final String title;
  final String description;
  final TimeOfDay time;
  final DateTime date;
  final LatLng location;

  EventModel({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'time': time.toMap(),
      'date': date.millisecondsSinceEpoch,
      // This is to convert it back to DateTime:
      // final int milliseconds = data['time'];
      // final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      // final DateTime notificationTime = eventTime.subtract(const Duration(minutes: 30)); // time i'll send the notification
      'location': location.toMap(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      title: map['title'] as String,
      description: map['description'] as String,
      time: TimeOfDay.fromMap(map['time'] as Map<String, dynamic>),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      location: LatLng.fromMap(map['location'] as Map<String, dynamic>),
    );
  }
}
