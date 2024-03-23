import 'package:course_13_native_device_features/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen(this.place, {Key? key}) : super(key: key);
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Center(
          child: Text(
            place.title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }
}
