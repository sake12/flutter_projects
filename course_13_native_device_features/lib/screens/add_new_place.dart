import 'dart:io';

import 'package:course_13_native_device_features/models/place.dart';
import 'package:course_13_native_device_features/providers/places_provider.dart';
import 'package:course_13_native_device_features/widgets/image_input.dart';
import 'package:course_13_native_device_features/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlaceScreen> {
  final _enteredTitle = TextEditingController();
  File? _selectedImage;
  PlaceLocations? _selectedLocation;

  _addPlace() {
    final title = _enteredTitle.text;

    if (title.isEmpty) {
      return;
    }
    if (_selectedImage == null) {
      return;
    }
    if (_selectedLocation == null) {
      return;
    }

    ref
        .read(placesProvider.notifier)
        .addNewPlace(title, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _enteredTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _enteredTitle,
            ),
            const SizedBox(height: 10),
            ImageInput(onPickImage: ((image) => _selectedImage = image)),
            const SizedBox(height: 10),
            LocationInput((location) => _selectedLocation = location),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _addPlace,
              label: const Text('Add item'),
            )
          ],
        ),
      ),
    );
  }
}
