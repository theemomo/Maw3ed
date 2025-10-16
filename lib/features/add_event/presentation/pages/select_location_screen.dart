
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjM4MWRjYjFmZjNkMjQ4YTZhMDZhMDljOGNlMWQ5MzczIiwiaCI6Im11cm11cjY0In0=';
  final MapController _mapController = MapController();
  List<Marker> markers = [];
  LocationData? currentLocation;
  LatLng? selectedLocation;
  List<LatLng> routePoints = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      LocationData userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        markers.add(
          Marker(
            width: 80,
            height: 80,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child: const Icon(Icons.my_location, color: Colors.blue, size: 20),
          ),
        );
      });

      // Listen for continuous updates
      location.onLocationChanged.listen((newLocation) {
        if (!mounted) return;
        setState(() {
          currentLocation = newLocation;
        });
      });
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  void _addDestinationMarker(LatLng point) {
    setState(() {
      markers = [markers.first]; // my location
      markers.add(
        Marker(
          width: 80,
          height: 80,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 30),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                initialZoom: 15,
                onTap: (tapPosition, point) {
                  _addDestinationMarker(point);
                  // selectedLocation = point;
                  Navigator.of(context).pop(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.maps',
                ),
                MarkerLayer(markers: markers),
                // if (routePoints.isNotEmpty)
                //   PolylineLayer(
                //     polylines: [Polyline(points: routePoints, strokeWidth: 4, color: Colors.blue)],
                //   ),
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
