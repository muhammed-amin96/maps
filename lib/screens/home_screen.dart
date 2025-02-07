import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static const CameraPosition _cairo = CameraPosition(
    target: LatLng(30.04455564564681, 31.233058466885144),
    zoom: 10.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    final marker = Marker(
      markerId: MarkerId('Cairo'),
      position: LatLng(30.04455564564681, 31.233058466885144),
      infoWindow: InfoWindow(
        title: 'Cairo',
      ),
    );

    setState(() {
      markers[MarkerId('Cairo')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cairo,
        onMapCreated: _onMapCreated,
        markers: markers.values.toSet(),
      ),
    );
  }
}
