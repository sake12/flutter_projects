import 'dart:io';

import 'package:course_13_native_device_features/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesProviderNotifier extends StateNotifier<List<Place>> {
  PlacesProviderNotifier() : super(const []);

  addNewPlace(String title, File image, PlaceLocations location) {
    final place = Place(title: title, image: image, location: location);
    state = [...state, place];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesProviderNotifier, List<Place>>((ref) {
  return PlacesProviderNotifier();
});
