import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
    'Notification 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor:
            Color(0xFF4F46E5), // Set the background color to #4F46E5
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notification),
            subtitle: Text('This is a sample notification.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailsScreen(notification: notification)),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationDetailsScreen extends StatelessWidget {
  final String notification;

  const NotificationDetailsScreen({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
        backgroundColor:
            Color(0xFF4F46E5), // Set the background color to #4F46E5
      ),
      body: Center(
        child: Text(notification),
      ),
    );
  }
}
