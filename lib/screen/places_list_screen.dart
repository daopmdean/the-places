import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_places/provider/great_places.dart';
import 'package:the_places/screen/add_place_screen.dart';
import 'package:the_places/screen/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<GreatPlaces>(
            child: const Center(
              child: Text('Got no places yet, start adding some!'),
            ),
            builder: (ctx, greatPlaces, child) => greatPlaces.items.isEmpty
                ? child!
                : ListView.builder(
                    itemCount: greatPlaces.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.items[i].image,
                        ),
                      ),
                      title: Text(greatPlaces.items[i].title),
                      subtitle: Text(greatPlaces.items[i].location!.address),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PlaceDetailScreen.routeName,
                          arguments: greatPlaces.items[i].id,
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
