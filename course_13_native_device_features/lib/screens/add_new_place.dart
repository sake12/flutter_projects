import 'package:course_13_native_device_features/models/place.dart';
import 'package:course_13_native_device_features/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({Key? key}) : super(key: key);

  @override
  createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlaceScreen> {
  final _enteredName = TextEditingController();

  _addPlace() {
    final place = Place(title: _enteredName.text);
    ref.read(placesProvider.notifier).addNewPlace(place);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _enteredName.dispose();
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
              controller: _enteredName,
            ),
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