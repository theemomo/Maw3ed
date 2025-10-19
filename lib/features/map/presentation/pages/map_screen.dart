import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:maw3ed/features/map/presentation/cubit/map_cubit.dart';
import 'package:maw3ed/features/map/presentation/widgets/map_screen_shimmer.dart';
import 'package:maw3ed/generated/l10n.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

    _getRoute(point);
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
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => MapCubit()..getAllEvents(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).findYourEventInMaps,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: const [],
          leading: const Text(""),
          centerTitle: true,
        ),
        body: currentLocation == null
            ? const MapScreenShimmer()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(20), // your radius
                    ),
                    width: size.width,
                    height: size.height * 0.4,
                    clipBehavior: Clip
                        .hardEdge, // Important when using Decoration + child
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        18,
                      ), // slightly less than border
                      child: FlutterMap(
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
                    ),
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: BlocBuilder<MapCubit, MapState>(
                        buildWhen: (previous, current) =>
                            current is GetEventsLoading ||
                            current is GetEventsLoaded,
                        builder: (context, state) {
                          if (state is GetEventsLoading) {
                            return const SizedBox();
                          } else if (state is GetEventsLoaded) {
                            if (state.userEvents.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: size.height * 0.05),
                                  Opacity(
                                    opacity: 0.7,
                                    child: CachedNetworkImage(
                                      width: size.width * 0.3,
                                      imageUrl:
                                          'https://cdn-icons-png.flaticon.com/512/969/969563.png',
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Text(
                                    S.of(context).noFutureEvents,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.userEvents.length,
                                itemBuilder: (context, index) {
                                  final List<Color> eventColors = [
                                    const Color(0xFFC9C3E5),
                                    const Color(0xFFE4B7B5),
                                    const Color(0xFFA9D0C3),
                                    const Color(0xFFD8DFAD),
                                    const Color(0xFFFFD6A5),
                                    const Color(0xFFB5EAD7),
                                    const Color(0xFFFFB7B2),
                                    const Color(0xFFA7C7E7),
                                  ];
                                  final List<Color> eventButtonColors = [
                                    const Color(0xFF4B3D91), // Dark Violet
                                    const Color(0xFF7B2F2D), // Deep Rosewood
                                    const Color(0xFF2E6E5C), // Dark Emerald
                                    const Color(0xFF63692C), // Army Olive
                                    const Color(
                                      0xFF8A4A00,
                                    ), // Deep Burnt Orange
                                    const Color(0xFF1E7B62), // Deep Teal
                                    const Color(0xFF8B1F19), // Crimson Coral
                                    const Color(0xFF174E89), // Midnight Blue
                                  ];
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return GestureDetector(
                                        onTap: () {
                                          _addDestinationMarker(
                                            state.userEvents[index].location,
                                          );
                                          if (currentLocation != null) {
                                            _mapController.move(
                                              LatLng(
                                                state
                                                    .userEvents[index]
                                                    .location
                                                    .latitude,
                                                state
                                                    .userEvents[index]
                                                    .location
                                                    .longitude,
                                              ),
                                              15,
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                eventColors[index %
                                                    eventColors.length],
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(30),
                                                  bottomLeft: Radius.circular(
                                                    30,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    30,
                                                  ),
                                                ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.userEvents[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: const Color(
                                                        0xFF1E1E1E,
                                                      ),
                                                    ),
                                              ),
                                              Text(
                                                state
                                                    .userEvents[index]
                                                    .description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                        0xFF1E1E1E,
                                                      ),
                                                    ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${state.userEvents[index].date.day} / ${state.userEvents[index].date.month} / ${state.userEvents[index].date.year}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color(
                                                            0xFF1E1E1E,
                                                          ),
                                                        ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 13,
                                                          vertical: 5,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          eventButtonColors[index %
                                                              eventColors
                                                                  .length],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      '${state.userEvents[index].time.hour.toString().padLeft(2, '0')}:${state.userEvents[index].time.minute.toString().padLeft(2, '0')}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                eventColors[index %
                                                                    eventColors
                                                                        .length],
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          }
                          return const Center(
                            child: Text("Something went wrong!"),
                          );
                        },
                      ),
                    ),
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
      ),
    );
  }
}
