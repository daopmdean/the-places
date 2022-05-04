import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:the_places/helper/db_repo.dart';
import 'package:the_places/model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    var newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DbRepo.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchPlaces() async {
    final data = await DbRepo.getData('user_places');
    _items = data
        .map(
          (row) => Place(
            id: row['id'],
            title: row['title'],
            location: null,
            image: File(row['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
