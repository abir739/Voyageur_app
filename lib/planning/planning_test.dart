import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voyageur_app/notification/notification.dart';

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 30));
  List<DateTime> _days = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateDays();
  }

  void _generateDays() {
    int days = _endDate.difference(_startDate).inDays + 1;
    for (int i = 0; i < days; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }
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
          color: isSelected ? Colors.blue : Colors.transparent,
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
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Content for ${DateFormat('MMM d, y').format(currentDay)}',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
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
              'Plan Title',
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
              leading: Icon(Icons.category),
              title: Text('Category 1'),
              onTap: () {
                // Navigate to Category 1 screen when pressed
                Navigator.pushNamed(context, '/category1');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category 2'),
              onTap: () {
                // Navigate to Category 2 screen when pressed
                Navigator.pushNamed(context, '/category2');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category 3'),
              onTap: () {
                // Navigate to Category 3 screen when pressed
                Navigator.pushNamed(context, '/category3');
              },
            ),
          ],
        ),
      );
    },
  );
}
