class Plan {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Day> days;

  Plan({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final startDate = DateTime.parse(json['start_date'] as String);
    final endDate = DateTime.parse(json['end_date'] as String);
    final daysJson = json['days'] as List<dynamic>;
    final days = daysJson
        .map((dayJson) => Day.fromJson(dayJson as Map<String, dynamic>))
        .toList();

    return Plan(
      name: name,
      startDate: startDate,
      endDate: endDate,
      days: days, // Initialize the days field here
    );
  }
}

class Day {
  final DateTime date;
  final List<Activity> activities;

  Day({required this.date, required this.activities});

  factory Day.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date'] as String);
    final activitiesJson = json['activities'] as List<dynamic>;
    final activities = activitiesJson
        .map((activityJson) =>
            Activity.fromJson(activityJson as Map<String, dynamic>))
        .toList();

    return Day(
      date: date,
      activities: activities, // Initialize the activities field here
    );
  }
}

class Activity {
  final Duration duration;
  final String type;
  final String icon;
  final String name;
  final String? comment;
  final String address;

  Activity({
    required this.duration,
    required this.type,
    required this.icon,
    required this.name,
    this.comment,
    required this.address,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    final duration = Duration(minutes: json['duration'] as int);
    final type = json['type'] as String;
    final icon = json['icon'] as String;
    final name = json['name'] as String;
    final comment = json['comment'] as String?;
    final address = json['address'] as String;

    return Activity(
      duration: duration,
      type: type,
      icon: icon,
      name: name,
      comment: comment,
      address: address, // Initialize the address field here
    );
  }
}
