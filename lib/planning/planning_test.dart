import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:voyageur_app/notification/notification.dart';
import 'package:voyageur_app/notification/notification_test.dart';
import 'package:voyageur_app/activites/hotels.dart';

import '../activites/visites.dart';

// the description of an activity

class Plan {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Day> days;

  Plan(
      {required this.name,
      required this.startDate,
      required this.endDate,
      required this.days});
}

class Day {
  final DateTime date;
  final List<Activity> activities;

  Day({required this.date, required this.activities});
}

class Activity {
  final String duration;
  final String type;
  final String icon;
  final String name;
  final String address;

  Activity(
      {required this.duration,
      required this.type,
      required this.icon,
      required this.name,
      required this.address});
}

class PlanScreen extends StatelessWidget {
  final Plan plan;

  const PlanScreen({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plan.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPlanInfo(),
          _buildDays(),
        ],
      ),
    );
  }

  Widget _buildPlanInfo() {
    return Column(
      children: [
        Text(
          '${DateFormat('MMM d, y').format(plan.startDate)} - ${DateFormat('MMM d, y').format(plan.endDate)}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDays() {
    return Expanded(
      child: ListView.builder(
        itemCount: plan.days.length,
        itemBuilder: (BuildContext context, int index) {
          final day = plan.days[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  DateFormat('EEE, MMM d').format(day.date),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildDayActivities(day.activities),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildDayActivities(List<Activity> activities) {
    return activities.map((activity) {
      return GestureDetector(
        onTap: () {
// Navigate to the activity detail screen
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(activity.duration),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(activity.icon, width: 30, height: 30),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                activity.type,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(activity.name),
            ],
          ),
        ),
      );
    }).toList();
  }
}
