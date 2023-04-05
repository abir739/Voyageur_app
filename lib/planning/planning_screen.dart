import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:voyageur_app/activites/hotels.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../activites/visites.dart';

// the description of an activity
class Activity {
  String name;
  String time;
  String logoPath;
  String symbolName;
  String photoPath;
  String place;
  String comment;
  String description;
  String price;

  Activity(
      {required this.name,
      required this.time,
      required this.price,
      required this.logoPath,
      required this.symbolName,
      required this.photoPath,
      required this.place,
      this.comment = "",
      required this.description});
}

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 3));
  DateTime _endDate = DateTime.now().add(Duration(days: 20));
  List<DateTime> _days = [];
  int _currentIndex = 0;

// exemple for list of activiies to test the activity list view
  final List<Activity> activities = [
    Activity(
      name: "Vols",
      time: "14:00-14:45",
      price: "0€",
      logoPath: 'assets/images/Vol.svg',
      symbolName: 'Aéroport de Tunis',
      photoPath:
          'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
      place: 'Aéroport tunis carthage',
      description:
          'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
    ),
    Activity(
      name: "Hotles",
      time: "16:00-16:50",
      price: "0€",
      logoPath: 'assets/images/hottt.svg',
      symbolName: 'Royal Azur Hotel Thalassa',
      photoPath:
          'https://fwk.resabo.com/cr.fwk/images/hotels/Hotel-8905-20230102-095053.jpg',
      place: 'Hammamet, Tunisie Station touristique',
      description:
          'L’Hôtel Royal Azur Thalassa propose une de?couverte Tunisienne à travers une déambulation dans ses espaces à caractère culturel profond.',
    ),
    Activity(
      name: "Visites",
      time: "17:00-18:00",
      price: "28,51€",
      logoPath: 'assets/images/vis.svg',
      symbolName: 'Sidi Bou Said',
      photoPath:
          "https://travelfree.info/wp-content/uploads/2020/06/tunisia-2425441_1280-e1593516163383.jpg",
      place: "Tunisia-tunis",
      description:
          "You could be forgiven for thinking that you’d made the hop across the Med to the islands of the Greek Aegean as you enter the vibrant interior of Sidi Bou Said town, sat just 20 kilometers from bustling Tunis.Yep, the sky-blue and whitewashed color scheme here is more than reminiscent of towns in Santorini and Mykonos.However, this one’s interesting hues were actually started by the French musicologist Rodolphe d’Erlanger.",
    ),
    Activity(
      name: "Restaurants",
      time: "19:00",
      price: "0€",
      logoPath: 'assets/images/restt.svg',
      symbolName: 'Restaurant Dar El Jeld',
      photoPath:
          'https://www.sejours-tunisie.com/wp-content/uploads/2019/02/meilleurs-restaurants-tunis.jpg',
      place: 'Tunisie, Tunis',
      description:
          'Dar El Jeld : avec sa localisation atypique au milieu du souk de Tunis, cette demeure exceptionnelle reconvertit en restaurant chic et raffiné propose divers plats orientaux et tunisiens d’exception : généreux et goûteux, vous serez agréablement séduit !',
    ),
    Activity(
      name: "Activities",
      time: "10:00-12:30",
      price: "48,51€",
      logoPath: 'assets/images/mount.svg',
      symbolName: 'lle de Djerba',
      photoPath:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/1b/31/caption.jpg?w=500&h=400&s=1',
      place: 'Par Djerba Explore',
      description: 'Ile de Djerba: excursion : une heure et demie en quad',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Generate a list of days between the start and end dates
    int daysDifference = _endDate.difference(_startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }
  }

  List<Widget> _buildBoxes() {
    // List of boxes to be built dynamically
    List<Widget> boxes = [];
    // Generate a random number of boxes between 3 and 10
    int numBoxes = 3 + DateTime.now().millisecond % 8;

    // Loop through the number of boxes and add them to the list
    for (int i = 0; i < numBoxes; i++) {
      for (int j = 0; j < activities.length; j++) {
        Activity index = activities[j];
        // Generate a random color for each box
        Random random = Random();
        Color boxColor = Color.fromARGB(
            255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
        // Generate a random height for each box between 50 and 150
        double boxHeight = 240.0 /*+ DateTime.now().millisecond % 100*/;

//Box's Detail

        // Build the box widget
        Widget box = GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoxDescriptionPage(
                  activity: index,
                ),
              ),
            );
          },
          child: Container(
            height: boxHeight,
            decoration: BoxDecoration(
              color: boxColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "${index.time}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 14),
                        ClipOval(
                          child: SvgPicture.asset(
                            index.logoPath,
                            fit: BoxFit.cover,
                            height: 40.0,
                          ),
                        ),
                        SizedBox(width: 8, height: 16),
                        Text(
                          index.name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        ClipOval(
                          child: Image.network(
                            index.photoPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 6, height: 80),
                        Text(
                          index.symbolName,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            'assets/images/place.svg',
                            width: 13,
                            height: 13,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 26, width: 10),
                        Text(
                          index.place,
                          style: TextStyle(
                            color: Color.fromARGB(255, 8, 8, 8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD1D5DB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _showCommentDialog(context, index);
                          },
                          child: Text(
                            "Add Comment",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          index.comment,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        // Add the box widget to the list of boxes
        boxes.add(box);
      }
    }
    return boxes;
  }

  Widget _buildDay(DateTime day) {
    String dayOfWeek = "";
    switch (day.weekday) {
      case 1:
        dayOfWeek = "MON";
        break;
      case 2:
        dayOfWeek = "TUE";
        break;
      case 3:
        dayOfWeek = "WED";
        break;
      case 4:
        dayOfWeek = "THU";
        break;
      case 5:
        dayOfWeek = "FRI";
        break;
      case 6:
        dayOfWeek = "SAT";
        break;
      case 7:
        dayOfWeek = "SUN";
        break;
    }
    bool isSelected = _currentIndex == _days.indexOf(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = _days.indexOf(day);
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 241, 210, 231)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            "$dayOfWeek ${day.day}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: (day == _currentIndex) ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaysList() {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildDay(_days[index]);
        },
      ),
    );
  }

  /*List<String> boxDescriptions = [
    'Box 1 description',
    'Box 2 description',
    'Box 3 description'
  ];*/

  Widget _buildPlanContent() {
    DateTime currentDay = _days[_currentIndex];
    // Generate a list of boxes with different colors and contents
    List<Widget> boxes = _buildBoxes();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (BuildContext context, int index) {
                /*return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoxDescriptionPage(
                            description: boxDescriptions[index]),
                      ),
                    );
                  },*/
                // child: Padding(
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: boxes[index],
                  //),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final start = DateFormat("MMM dd, yyyy").format(_startDate);
    final end = DateFormat("MMM dd, yyyy").format(_endDate);
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(
            255, 207, 207, 219), // Set the background color to #4F46E5
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Planning 1',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDaysList(),
          Expanded(
            child: _buildPlanContent(),
          ),
        ],
      ),
    );
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
              leading: const Icon(Icons.category),
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

void _showCommentDialog(BuildContext context, Activity activity) {
  TextEditingController commentController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(hintText: "Enter comment"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              activity.comment = commentController.text;
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}

List<String> boxDescriptions = [
  'Box 1 description',
  'Box 2 description',
  'Box 3 description'
];

class BoxDescriptionPage extends StatelessWidget {
  final Activity activity;

  BoxDescriptionPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activity.name,
          style: TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
      ),
      body: Container(
        margin: EdgeInsets.all(20),

        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(activity.photoPath),
            SizedBox(height: 16),
            /* Text(place.time),*/

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 153, 158, 233).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    activity.time,
                    style: TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
                SizedBox(width: 146),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 153, 158, 233).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Price : ${activity.price}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              activity.symbolName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            /*SizedBox(height: 8),
          Text(place.address),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/images/place.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8, width: 6),
                Text(
                  activity.place,
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
            Text(activity.description),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Accept", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 252, 56, 121)),
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
      ),
    );
  }
}
