import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailto/mailto.dart';
import 'package:voyageur_app/claims/create_claims.dart';
import 'package:voyageur_app/guide/profile_item.dart';
import 'package:voyageur_app/planning/planning_screen.dart';
import '../activites/visites.dart';
import 'package:voyageur_app/about_page.dart';

_makingPhoneCall(number) async {
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

_whatsapp(number) async {
  await launch(
      "https://wa.me/$number?text=Hi, how are you?\n Can we meet tomorrow?");
}

_mail(eMail) async {
  final mailtoLink = Mailto(
      to: ["$eMail"],
      subject: "Extra Activity",
      body: "I send this mail bc I called u but u didn't reply , I want to tell u about our activity for tommorow.");
  await launch("$mailtoLink");
}

_instagram(username) async {
  await launch("https://www.instagram.com/$username/");
}

_facebook(username) async {
  await launch("https://www.facebook.com/$username/");
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF353657).withOpacity(0.99),
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(
                width: 30.0), // Add spacing between the logo and the text
            const Text('Guide Profile'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 105,
              backgroundImage: AssetImage("assets/images/ppp.jpg"),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _makingPhoneCall("+216 92871567");
                    },
                    child: const ProfileItem(
                      title: "Call Me",
                      icon: Icons.call,
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        _whatsapp("+216 92871567");
                      },
                      child: const ProfileItem(
                          title: "WhatsApp", icon: Icons.message)),
                  GestureDetector(
                    onTap: () async {
                      await _mail("Adam_Garfa.93@gmail.com");
                    },
                    child: const ProfileItem(
                      title: "E-mail",
                      icon: Icons.mail,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _instagram("instagram");
                    },
                    child: const ProfileItem(
                      title: "Instagram",
                      icon: Icons.camera,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _facebook("facebook");
                    },
                    child: const ProfileItem(
                      title: "Facebook",
                      icon: Icons.facebook,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

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
                          title: const Text('Home', style: TextStyle(color: active)),
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
                          leading: const Icon(Icons.contact_page, color: active),
                          title:
                              const Text('My guide', style: TextStyle(color: active)),
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
                        _buildDivider(),
                        ListTile(
                          leading:
                              const Icon(Icons.attach_money_sharp, color: active),
                          title: const Text('Transfer and exchange of money',
                              style: TextStyle(color: active)),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ClientScreen()),
                            // );
                          },
                        ),
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
                          leading: const Icon(Icons.location_city, color: active),
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
                          leading: const Icon(Icons.feedback_sharp, color: active),
                          title: const Text('create claims',
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
                              trailing: const Icon(Icons.login, color: Colors.red),
                              onTap: () {
                                Navigator.of(context).pop();
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
