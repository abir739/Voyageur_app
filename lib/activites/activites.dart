import 'package:flutter/material.dart';

Widget _buildDayActivityList(String day) {
  List<Widget> activityWidgets = [];

  // Replace with your own logic to retrieve the list of activities for the given day
  List<String> activities = ['Activity 1', 'Activity 2', 'Activity 3'];

  for (String activity in activities) {
    activityWidgets.add(
      ListTile(
        title: Text(activity),
        subtitle: Text(
            '10:00 AM - 11:00 AM'), // Replace with the time of the activity
      ),
    );
  }

  return ListView(
    children: activityWidgets,
  );
}
