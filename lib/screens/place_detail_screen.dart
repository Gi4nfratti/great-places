import 'package:flutter/material.dart';
import 'package:great_places/screens/map_screen.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
        Text(
          place.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(height: 10),
        ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    isReadonly: true,
                    initialLocation: place.location,
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: Icon(Icons.map),
            style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                    TextStyle(color: Theme.of(context).primaryColor))),
            label: Text('Ver no Mapa'))
      ]),
    );
  }
}
