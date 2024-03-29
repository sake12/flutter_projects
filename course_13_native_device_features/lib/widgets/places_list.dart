import 'package:course_13_native_device_features/models/place.dart';
import 'package:course_13_native_device_features/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList({required this.places, super.key});

  void _goToDetails(Place place, BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PlaceDetailScreen(place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(
        child: Text(
          'No places added yet.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(places[index].title),
        onTap: () => _goToDetails(places[index], context),
      ),
    );
  }
}
