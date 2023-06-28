import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:voyageur_app/models/place_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:voyageur_app/claims/create_claims_test.dart';
import '../guide/guide_profile_test.dart';
import '../planning/planning_screen.dart';
import 'package:voyageur_app/about_page.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(place.imageUrl),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 163, 97, 175).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  place.time,
                  style: const TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            place.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/images/place.svg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8, width: 6),
              Text(
                place.address,
                style: const TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Divider(
            color: Color.fromARGB(255, 189, 184, 184),
            thickness: 2.0,
          ),
          const SizedBox(height: 16),
          const Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(place.description),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                top: 66.0 + 16.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              margin: const EdgeInsets.only(top: 66.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 16.0,
                                    offset: Offset(0.0, 16.0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Confirmation",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    "You accepted this activity.",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.teal,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Submit",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 24.0 + 66.0,
                              right: 24.0 + 66.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    Image.network(place.imageUrl).image,
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF4F46E5),
                  ),
                  child: const Text("Accept",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.TOPSLIDE,
                    dialogType: DialogType.WARNING,
                    title: 'Decline',
                    desc: 'Are you sure you want to decline this activity?',
                    btnOkIcon: Icons.check_circle,
                    btnOkColor: Colors.green.shade900,
                    btnOkOnPress: () {
                      // Action to perform when "OK" button is pressed.
                    },
                  ).show();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 214, 208, 208)),
                ),
                child: const Text("Decline",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VisitesScreen extends StatefulWidget {
  const VisitesScreen({super.key});

  @override
  _VisitesScreenState createState() => _VisitesScreenState();
}

class _VisitesScreenState extends State<VisitesScreen> {
  final PageController _pageController = PageController();
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
        title: const Text(
          'Visite/Activity',
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
//

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
