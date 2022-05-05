import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyAzM20vwcknz5eEQtvr1rOQkYTEGiV2v2E';
// String.fromEnvironment('GOOGLE_API_KEY');
// Platform.environment['GOOGLE_API_KEY'];

class LocationHelper {
  static String getLocationImage({
    required double lat,
    required double long,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7Clabel:H%7C$lat,$long&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress({
    required double lat,
    required double long,
  }) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY');
    final res = await http.get(url);
    if (res.statusCode >= 400) {
      throw Exception('error calling google geocode');
    }

    return json.decode(res.body)['results'][0]['formatted_address'];
  }
}
