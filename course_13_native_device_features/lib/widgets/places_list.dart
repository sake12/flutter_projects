import 'dart:developer';

import 'package:course_13_native_device_features/models/place.dart';
import 'package:course_13_native_device_features/providers/places_provider.dart';
import 'package:course_13_native_device_features/widgets/add_new_place.dart';
import 'package:course_13_native_device_features/widgets/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({super.key});

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  void _addNewPlace() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNewPlace(),
      ),
    );
  }

  void _goToDetails(Place place) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PlaceDetail(place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: _addNewPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: places.isEmpty
          ? const Center(
              child: Text(
                'No places added yet.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(places[index].title),
                  onTap: () => _goToDetails(places[index]),
                );
              },
            ),
    );
  }
}
