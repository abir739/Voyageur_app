import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:voyageur_app/activites/hotels.dart';

// the description of an activity
class Activity {
  String name;
  String time;
  String logoPath;
  String symbolName;
  String photoPath;
  String place;
  String comment;

  Activity(
      {required this.name,
      required this.time,
      required this.logoPath,
      required this.symbolName,
      required this.photoPath,
      required this.place,
      this.comment = ""});
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
      time: "2:00 PM",
      logoPath: 'assets/images/avion2.png',
      symbolName: 'Aéroport de Tunis',
      photoPath: 'assets/logos/logo.png',
      place: 'ASL Airlines France',
    ),
    Activity(
      name: "Hotles",
      time: "10:00 AM",
      logoPath: 'assets/images/hotel.png',
      symbolName: 'Hotel Carlton',
      photoPath: 'assets/logos/logo.png',
      place: 'Av.Habib Bourguiba',
    ),
    Activity(
      name: "Restaurants",
      time: "2:00 PM",
      logoPath: 'assets/images/food.png',
      symbolName: 'Aromate Restaurant',
      photoPath: 'assets/logos/logo.png',
      place: 'Douze 4260 Tunisie',
    ),
    Activity(
      name: "Visites",
      time: "6:00 PM",
      logoPath: 'assets/images/maps.png',
      symbolName: 'lle de Djerba',
      photoPath: 'assets/logos/logo.png',
      place: 'Par Djerba Explore',
    ),
    Activity(
      name: "Activities",
      time: "8:00 PM",
      logoPath: 'assets/images/maps.png',
      symbolName: 'lle de Djerba',
      photoPath: 'assets/logos/logo.png',
      place: 'Par Djerba Explore',
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
    //int numBoxes = 3 + DateTime.now().millisecond % 8;
    int numBoxes = 5;
    // Loop through the number of boxes and add them to the list
    for (int i = 0; i < numBoxes; i++) {
      for (int j = 0; j < activities.length; j++) {
        Activity index = activities[j];
        // Generate a random color for each box
        Color boxColor = Colors
            .primaries[DateTime.now().millisecond % Colors.primaries.length];
        // Generate a random height for each box between 50 and 150
        double boxHeight = 270.0 /*+ DateTime.now().millisecond % 100*/;
        // Build the box widget
        Widget box = Container(
          height: boxHeight,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Time: ${index.time}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 14),
                      ClipOval(
                        child: Image.asset(
                          index.logoPath,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16, height: 46),
                      Text(
                        index.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 26),
                      ClipOval(
                        child: Image.asset(
                          index.logoPath,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8, height: 80),
                      Text(
                        index.symbolName,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Divider(
                    color: Colors.black,
                    thickness: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/flag3.png',
                          width: 40,
                          height: 40,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(5),
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
                    SizedBox(height: 16.0),
                    Divider(
                      color: Colors.black,
                      thickness: 2.0,
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
        );
        // Add the box widget to the list of boxes
        boxes.add(box);
      }
    }
    return boxes;
  }

  Widget _buildDay(DateTime day) {
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
              ? Color.fromARGB(255, 154, 58, 199)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            DateFormat('d').format(day),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
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

  Widget _buildPlanContent() {
    DateTime currentDay = _days[_currentIndex];
    // Generate a list of boxes with different colors and contents
    List<Widget> boxes = _buildBoxes();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Content for ${DateFormat('MMM d, y').format(currentDay)}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: boxes[index],
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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/logo.png',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(
            255, 141, 135, 248), // Set the background color to #4F46E5
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
              'Plan n° 1',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: TextStyle(
                fontSize: 18.0,
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
                Navigator.pushNamed(context, '/Visite');
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
