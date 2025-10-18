// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EventModel {
  final String? uId;
  final String title;
  final String description;
  final TimeOfDay time;
  final DateTime date;
  final LatLng location;

  EventModel({
    this.uId,
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

  EventModel copyWith({
    String? uId,
    String? title,
    String? description,
    TimeOfDay? time,
    DateTime? date,
    LatLng? location,
  }) {
    return EventModel(
      uId: uId ?? this.uId,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      date: date ?? this.date,
      location: location ?? this.location,
    );
  }
}
