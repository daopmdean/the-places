const GOOGLE_API_KEY = 'AIzaSyAzM20vwcknz5eEQtvr1rOQkYTEGiV2v2E';
// String.fromEnvironment('GOOGLE_API_KEY');
// Platform.environment['GOOGLE_API_KEY'];

class LocationHelper {
  static String getCurrentLocation({
    required double lat,
    required double long,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7Clabel:H%7C$lat,$long&key=$GOOGLE_API_KEY';
  }
}
