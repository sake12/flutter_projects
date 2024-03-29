import 'package:course_13_native_device_features/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
