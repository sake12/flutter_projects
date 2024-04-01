import 'package:course_13_native_device_features/providers/places_provider.dart';
import 'package:course_13_native_device_features/screens/add_new_place.dart';
import 'package:course_13_native_device_features/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddNewPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(places: places),
      ),
    );
  }
}
