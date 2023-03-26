import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 90));
  DateTime currentDate = DateTime.now();

  List<Box> boxes = [];

  void generateBoxes() {
    Random random = Random();
    int numBoxes = random.nextInt(10) + 1;
    boxes.clear();
    for (int i = 0; i < numBoxes; i++) {
      Color color = Color.fromARGB(
          255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
      String content = "Box $i";
      boxes.add(Box(color, content));
    }
  }

  @override
  void initState() {
    super.initState();
    generateBoxes();
  }

  @override
  Widget build(BuildContext context) {
    final start = DateFormat("MMM dd, yyyy").format(startDate);
    final end = DateFormat("MMM dd, yyyy").format(endDate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Planning Screen"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Plan",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '$start ~ $end',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 40.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (endDate.difference(startDate).inDays + 1),
              itemBuilder: (BuildContext context, int index) {
                DateTime day = startDate.add(Duration(days: index));
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
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentDate = day;
                      generateBoxes();
                    });
                  },
                  child: Container(
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (day == currentDate)
                            ? Colors.blue
                            : Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "$dayOfWeek ${day.day}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color:
                              (day == currentDate) ? Colors.blue : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: boxes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: boxes[index].color.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      boxes[index].content,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Box {
  final Color color;
  final String content;

  Box(this.color, this.content);
}
