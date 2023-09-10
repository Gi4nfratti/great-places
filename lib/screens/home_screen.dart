import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Text('Nenhum local cadastrado',
                        style: TextStyle(fontSize: 20)),
                  ),
                  builder: (context, greatPlaces, ch) =>
                      greatPlaces.itemsCount == 0
                          ? ch!
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListView.builder(
                                itemCount: greatPlaces.itemsCount,
                                itemBuilder: (context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        greatPlaces.itemByIndex(index).image),
                                  ),
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        greatPlaces.itemByIndex(index).title,
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  subtitle: Text(greatPlaces
                                      .itemByIndex(index)
                                      .location
                                      .address),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.PLACE_DETAIL,
                                        arguments:
                                            greatPlaces.itemByIndex(index));
                                  },
                                ),
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
