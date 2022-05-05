import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:the_places/helper/location_helper.dart';
import 'package:the_places/screen/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: const Icon(
                Icons.location_on,
              ),
              label: const Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: const Icon(
                Icons.map,
              ),
              label: const Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();
    final staticMapUrl = LocationHelper.getCurrentLocation(
      lat: location.latitude!,
      long: location.longitude!,
    );
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedPlace =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => const MapScreen(
        isSelecting: true,
      ),
    ));
    if (selectedPlace == null) {
      return;
    }
  }
}
