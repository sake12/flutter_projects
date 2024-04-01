import 'dart:convert';

import 'package:course_13_native_device_features/models/place.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.onSelectLocation, {super.key});

  final void Function(PlaceLocations location) onSelectLocation;

  @override
  createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocations? _pickedLocation;
  var isGettingLocation = false;

  static const apiKey = 'AIzaSyBHXvplZgEUOqCsA54Y4JsiaYFkvY3yHH0';

  String get locationImage {
    final lat = _pickedLocation?.latitude;
    final lng = _pickedLocation?.longitude;
    if (lat == null || lng == null) {
      return '';
    }

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    final locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');

    final response = await http.get(url);

    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocations(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'No location chosen',
      textAlign: TextAlign.center,
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }

    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select location'),
            )
          ],
        )
      ],
    );
  }
}
