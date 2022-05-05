import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_places/model/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  final PlaceLocation initLocation;
  final bool isSelecting;

  const MapScreen({
    Key? key,
    this.initLocation = const PlaceLocation(
      latitude: 37.42,
      longitude: -122.08,
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initLocation.latitude,
            widget.initLocation.longitude,
          ),
          zoom: 14,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: generateMaker(),
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Set<Marker> generateMaker() {
    if (_pickedLocation == null && widget.isSelecting) {
      return {};
    }

    if (_pickedLocation == null) {
      return {
        Marker(
          markerId: const MarkerId('m1'),
          position: LatLng(
            widget.initLocation.latitude,
            widget.initLocation.longitude,
          ),
        ),
      };
    }

    return {
      Marker(
        markerId: const MarkerId('m1'),
        position: _pickedLocation!,
      ),
    };
  }
}
