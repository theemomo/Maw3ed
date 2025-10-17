import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class FindRouteScreen extends StatefulWidget {
  final LatLng location;
  const FindRouteScreen({super.key, required this.location});

  @override
  State<FindRouteScreen> createState() => _FindRouteScreenState();
}

class _FindRouteScreenState extends State<FindRouteScreen> {
  final MapController _mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  String apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjM4MWRjYjFmZjNkMjQ4YTZhMDZhMDljOGNlMWQ5MzczIiwiaCI6Im11cm11cjY0In0=';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  // get current location
  Future<void> _getCurrentLocation() async {
    Location location = Location();
    try {
      LocationData userLocation = await location.getLocation();
      debugPrint(userLocation.toString());
      setState(() {
        currentLocation = userLocation;

        // add marker
        markers.add(
          Marker(
            width: 80,
            height: 80,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child: const Icon(Icons.my_location, color: Colors.blue, size: 20),
          ),
        );
      });
    } catch (e) {
      currentLocation = null;
    }

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
    _getRoute(widget.location);
  }

  // Get Route
  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;
    final start = LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );
    final response = await http.get(
      Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        routePoints = coords
            .map((coord) => LatLng(coord[1], coord[0]))
            .toList();
        markers.add(
          Marker(
            point: destination,
            width: 80,
            height: 80,
            child: const Icon(Icons.location_on, color: Colors.red, size: 30),
          ),
        );
      });
    } else {
      debugPrint('Failed to fetch route!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Go To Your Maw'ed",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              initialZoom: 15,
              onTap: (tapPosition, point) {},
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.maps',
              ),
              MarkerLayer(markers: markers),
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 4,
                      color: Colors.blue,
                    ),
                  ],
                ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentLocation != null) {
            _mapController.move(
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              15,
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
