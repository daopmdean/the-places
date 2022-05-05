import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:the_places/helper/db_repo.dart';
import 'package:the_places/helper/location_helper.dart';
import 'package:the_places/model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(String title, File image, PlaceLocation pickedLocation) async {
    String address = await LocationHelper.getPlaceAddress(
      lat: pickedLocation.latitude,
      long: pickedLocation.longitude,
    );
    var newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address,
      ),
      image: image,
    );
    _items.add(newPlace);

    notifyListeners();

    DbRepo.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': pickedLocation.latitude,
      'loc_long': pickedLocation.longitude,
      'address': address,
    });
  }

  Future<void> fetchPlaces() async {
    final data = await DbRepo.getData('user_places');
    _items = data
        .map(
          (row) => Place(
            id: row['id'],
            title: row['title'],
            location: PlaceLocation(
              latitude: row['loc_lat'],
              longitude: row['loc_long'],
              address: row['address'],
            ),
            image: File(row['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
