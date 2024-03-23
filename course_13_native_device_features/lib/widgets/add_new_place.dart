import 'dart:math';

import 'package:course_13_native_device_features/models/place.dart';
import 'package:course_13_native_device_features/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({Key? key}) : super(key: key);

  @override
  createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';

  _addPlace() {
    _formKey.currentState!.save();

    final place = Place(id: Random().nextInt(100), title: _enteredName);
    ref.read(placesProvider.notifier).addNewPlace(place);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _addPlace,
                    label: const Text('Add item'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
