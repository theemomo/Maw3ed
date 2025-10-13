import 'package:latlong2/latlong.dart';

class AddEventModel {
  final String title;
  final String description;
  final DateTime time;
  final DateTime date;
  final LatLng location;

  AddEventModel({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': title,
      'date': date.millisecondsSinceEpoch,
      'time': time.millisecondsSinceEpoch,
      'location': location.toMap(),
      'notes': description,
    };
  }

  factory AddEventModel.fromMap(Map<String, dynamic> map) {
    return AddEventModel(
      title: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      time: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      location: LatLng.fromMap(map['location'] as Map<String, dynamic>),
      description: map['notes'] as String,
    );
  }
}
