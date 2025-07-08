import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:meca_note_mobile/back-office/client/detail_garage_screen.dart';
import 'package:meca_note_mobile/utils/geolocation_helper.dart';
import 'package:meca_note_mobile/widgets/button_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:meca_note_mobile/widgets/go_back_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  _setCurrentPosition() async {
    var pos = await GeolocationHelper.determinePosition();
    setState(() {
      _center = LatLng(pos.latitude, pos.longitude);
      _loading = false;
    });
  }

  // Sample locations
  late final LatLng _center; // San Francisco
  final LatLng _marker1 = LatLng(37.7849, -122.4094);
  final LatLng _marker2 = LatLng(37.7649, -122.4294);

  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  List<Polygon> _polygons = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  void _initializeMapData() async {
    await _setCurrentPosition();

    // Initialize markers
    _markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: _center,
        child: GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const DetailGarageScreen(),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child:  Text(
                    "Garage Kulunas Yi".substring(0,15)+'...',
                    style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
                  )),
              const Icon(
                Icons.location_pin,
                color: Colors.blue,
                size: 40.0,
              ),
            ],
          ),
        ),
      ),
    ];

    // Initialize polylines (lines between points)
    _polylines = [
      Polyline(
        points: [_center, _marker1, _marker2],
        color: Colors.blue,
        strokeWidth: 3.0,
      ),
    ];

    // Initialize polygons (closed shapes)
    _polygons = [
      Polygon(
        points: [
          LatLng(37.7600, -122.4000),
          LatLng(37.7700, -122.4000),
          LatLng(37.7700, -122.4100),
          LatLng(37.7600, -122.4100),
        ],
        color: Colors.orange.withOpacity(0.3),
        borderStrokeWidth: 2.0,
        borderColor: Colors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: MyButtonWidget.goBack(context),
        backgroundColor: Colors.white.withOpacity(0.9),
        title: TitleWidget.setTitle("Cartes Garages"),
      ),
      body: _loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 100,
                  ),
                  const Text("Chargement en cours ..."),
                ],
              ),
            )
          : Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _center,
                    initialZoom: 13.0,
                    minZoom: 5.0,
                    maxZoom: 18.0,
                  ),
                  children: [
                    // Tile layer (map tiles)
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                      maxZoom: 18,
                    ),
                    MarkerLayer(
                      markers: _markers,
                    ),
                  ],
                ),

                // Control buttons
                Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          _mapController.move(_center, 13.0);
                        },
                        child: Icon(Icons.home),
                        heroTag: "home",
                      ),
                      SizedBox(height: 10),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(
                              _mapController.camera.center, currentZoom + 1);
                        },
                        child: Icon(Icons.zoom_in),
                        heroTag: "zoom_in",
                      ),
                      SizedBox(height: 10),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(
                              _mapController.camera.center, currentZoom - 1);
                        },
                        child: Icon(Icons.zoom_out),
                        heroTag: "zoom_out",
                      ),
                    ],
                  ),
                ),
              ],
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _clearMarkers();
      //   },
      //   child: Icon(Icons.clear),
      //   tooltip: 'Clear markers',
      // ),
    );
  }

  // void _addMarker(LatLng point) {
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         width: 80.0,
  //         height: 80.0,
  //         point: point,
  //         child: Container(
  //           child: Icon(
  //             Icons.location_pin,
  //             color: Colors.purple,
  //             size: 40.0,
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  void _clearMarkers() {
    setState(() {
      // Keep only the original 3 markers
      _markers = _markers.take(3).toList();
    });
  }
}
