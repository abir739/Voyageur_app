import 'dart:convert';
import 'package:voyageur_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyageur_app/activites/hotels.dart';
// import 'package:voyageur_app/lib/planning/planning_srcreen.dart';
import '../planning/planning_screen.dart';
import '../activites/visites.dart';

import 'package:voyageur_app/claims/create_claims_test.dart';
import 'package:voyageur_app/about_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../guide/guide_profile_test.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationModel> notifications;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() async {
    String data = await rootBundle.loadString('assets/json/notifications.json');
    final jsonResult = json.decode(data);

    setState(() {
      notifications = List<NotificationModel>.from(
          jsonResult.map((data) => NotificationModel.fromJson(data)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 207, 207, 219), // Set the background color to #4F46E5

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: notifications != null
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(notifications[index].senderPhotoUrl),
                    ),
                    title: Row(
                      children: [
                        Text('${notifications[index].senderName} - '),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 163, 97, 175)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            notifications[index].senderType,
                            style: const TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(notifications[index].time),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  notifications[index].messagePhotoUrl),
                              radius:
                                  40, // set the radius to half of the width and height
                            ),
                            const SizedBox(height: 10),
                            Text(
                              ' ${notifications[index].messageType}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          notifications[index].address,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(notifications[index].activityTime),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  headerAnimationLoop: false,
                                  animType: AnimType.SCALE,
                                  title: 'Confirmation',
                                  desc:
                                      'Do you really want to decline this activity?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 214, 208, 208),
                                ),
                              ),
                              child: const Text(
                                'Decline',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  headerAnimationLoop: false,
                                  animType: AnimType.SCALE,
                                  title: 'Confirmation',
                                  desc:
                                      'Nice! You will participate in this activity.',
                                  btnOkOnPress: () {},
                                )..show();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xFF4F46E5),
                                ),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// Define a function to show the menu options
// void _showMenu(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         child: Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: const Icon(Icons.local_hotel_outlined),
//               title: const Text('Hotels'),
//               onTap: () {
//                 // Navigate to hotels screen when pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const HotelListScreen(
//                             hotels: [
//                               {
//                                 'name': 'Hotel A',
//                                 'image': 'assets/images/hotel-img.png',
//                                 'time': '15:00-16:00',
//                                 'fullName': 'Hotel Carlton',
//                                 'rating': 4,
//                                 'address': '123 Main St, Anytown USA',
//                               },
//                               {
//                                 'name': 'Hotel B',
//                                 'image': 'hotel_b.jpg',
//                                 'time': '45 minutes',
//                                 'fullName': 'Hotel B Full Name',
//                                 'rating': 3,
//                                 'address': '456 Oak St, Anycity USA',
//                               },
//                               // Add more hotels here...
//                             ],
//                           )),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.category),
//               title: const Text('Restaurants'),
//               onTap: () {
//                 // Navigate to restaurants screen when pressed
//                 Navigator.pushNamed(context, '/restaurants');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.map_sharp),
//               title: const Text('Activié/Visite'),
//               onTap: () {
//                 // Navigate to activites screen when pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const VisitesScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

void _showMenu(BuildContext context) {
  const Color primary = Colors.white;
  const Color active = Colors.black;

  double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Set the desired width
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 77,
          child: ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Drawer(
              child: Container(
                padding: const EdgeInsets.only(left: 26.0, right: 140),
                decoration: const BoxDecoration(
                  color: primary,
                  boxShadow: [BoxShadow(color: Colors.black45)],
                ),
                width: 300,
                child: SafeArea(
                  /// ---------------------------
                  /// Building scrolling  content for drawer .
                  /// ---------------------------

                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //     icon: Icon(
                        //       Icons.power_settings_new,
                        //       color: active,
                        //     ),
                        //     onPressed: () {},
                        //   ),
                        // ),

                        /// ---------------------------
                        /// Building header for drawer .
                        /// ---------------------------
                        const SizedBox(height: 28.0),
                        Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/abir.jpeg',
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),

                        /// ---------------------------
                        /// Building header title for drawer .
                        /// ---------------------------

                        Text(
                          "Abir Cherif",
                          style: TextStyle(
                              color: Colors.purple.withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "@Abir.ch",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),

                        /// ---------------------------
                        /// Building items list  for drawer .
                        /// ---------------------------
                        const SizedBox(height: 16.0),
                        ListTile(
                          leading: const Icon(Icons.home, color: active),
                          title: const Text('Home',
                              style: TextStyle(color: active)),
                          onTap: () {
                            //  Navigate to home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlanningScreen()),
                            );
                          },
                        ),

                        _buildDivider(),
                        ListTile(
                          leading:
                              const Icon(Icons.contact_page, color: active),
                          title: const Text('My guide',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                        title: '',
                                      )),
                            );
                          },
                        ),
                        // _buildDivider(),
                        // ListTile(
                        //   leading: const Icon(Icons.attach_money_sharp,
                        //       color: active),
                        //   title: const Text('Transfer and exchange of money',
                        //       style: TextStyle(color: active)),
                        //   onTap: () {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //       builder: (context) => ClientScreen()),
                        //     // );
                        //   },
                        // ),
                        // _buildDivider(),
                        // ListTile(
                        //   leading: Icon(Icons.notification_add, color: active),
                        //   title: Text('Create Notification',
                        //       style: TextStyle(color: active)),
                        //   onTap: () {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //       builder: (context) => AddNotification()),
                        //     // );
                        //   },
                        // ),

                        _buildDivider(),
                        ListTile(
                          leading:
                              const Icon(Icons.location_city, color: active),
                          title: const Text('Destinations',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VisitesScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading:
                              const Icon(Icons.feedback_sharp, color: active),
                          title: const Text('Create claims',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateComplaintsScreen()),
                            );
                          },
                        ),

                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.info, color: active),
                          title: Text('About', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()),
                            );
                          },
                        ),

                        /// ---------------------------
                        /// last Item for drawer
                        /// ---------------------------

                        _buildDivider(),
                        const SizedBox(height: 28.0),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Log out',
                                style: TextStyle(
                                  fontFamily: 'Bahij Janna',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.purple.withOpacity(0.6),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing:
                                  const Icon(Icons.login, color: Colors.red),
                              onTap: () {
                                SystemNavigator.pop();
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Divider _buildDivider() {
  const Color divider = Colors.deepOrange;
  return const Divider(
    color: divider,
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * (2 / 3) - 20, 0);
    path.quadraticBezierTo(size.width * (2.2 / 3), size.height / 4,
        size.width * (2.2 / 3), size.height / 2);
    path.quadraticBezierTo(
        size.width * (2.2 / 3),
        size.height - (size.height / 4),
        size.width * (2 / 3) - 20,
        size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
