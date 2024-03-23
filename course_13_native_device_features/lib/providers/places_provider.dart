import 'package:course_13_native_device_features/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesProviderNotifier extends StateNotifier<List<Place>> {
  PlacesProviderNotifier() : super([]);

  addNewPlace(Place place) {
    state = [...state, place];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesProviderNotifier, List<Place>>((ref) {
  return PlacesProviderNotifier();
});
