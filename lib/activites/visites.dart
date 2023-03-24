import 'dart:convert';
import 'package:voyageur_app/models/place_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:voyageur_app/activites/hotels.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),

      //child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(place.imageUrl),
          /*SizedBox(height: 16),
          Text(place.time),*/

          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 163, 97, 175).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  place.time,
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            place.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          /*SizedBox(height: 8),
          Text(place.address),*/

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/Icon.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8, width: 6),
              Text(
                place.address,
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(
            color: Color.fromARGB(255, 189, 184, 184),
            thickness: 2.0,
          ),
          SizedBox(height: 16),
          Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(place.description),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Accept", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF4F46E5)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Decline", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 214, 208, 208)),
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}

class VisitesScreen extends StatefulWidget {
  @override
  _VisitesScreenState createState() => _VisitesScreenState();
}

class _VisitesScreenState extends State<VisitesScreen> {
  PageController _pageController = PageController();
  List<Place> _places = [];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visite/Activity'),
        backgroundColor: Color.fromARGB(
            255, 122, 115, 241), // Set the background color to #4F46E5

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _places.length,
        itemBuilder: (BuildContext context, int index) {
          return PlaceCard(place: _places[index]);
        },
      ),
    );
  }

  void _loadPlaces() async {
    String data = await rootBundle.loadString(
        'assets/json/visites.json'); // assuming the JSON file is in the assets folder
    List<dynamic> placesJson = jsonDecode(data);
    List<Place> places =
        placesJson.map((placeJson) => Place.fromJson(placeJson)).toList();
    setState(() {
      _places = places;
    });
  }
}

// Define a function to show the menu options
void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.local_hotel_outlined),
              title: const Text('Hotels'),
              onTap: () {
                // Navigate to hotels screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelListScreen(
                            hotels: [
                              {
                                'name': 'Hotel A',
                                'image': 'assets/images/hotel-img.png',
                                'time': '15:00-16:00',
                                'fullName': 'Hotel Carlton',
                                'rating': 4,
                                'address': '123 Main St, Anytown USA',
                              },
                              {
                                'name': 'Hotel B',
                                'image': 'hotel_b.jpg',
                                'time': '45 minutes',
                                'fullName': 'Hotel B Full Name',
                                'rating': 3,
                                'address': '456 Oak St, Anycity USA',
                              },
                              // Add more hotels here...
                            ],
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Restaurants'),
              onTap: () {
                // Navigate to restaurants screen when pressed
                Navigator.pushNamed(context, '/restaurants');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map_sharp),
              title: const Text('Activié/Visite'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisitesScreen()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
