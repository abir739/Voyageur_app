import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:voyageur_app/claims/create_claims_test.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../activites/visites.dart';
import '../guide/guide_profile_test.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:voyageur_app/about_page.dart';

// the description of an activity
class Activity {
  String name;
  String time;
  String logoPath;
  String symbolName;
  String photoPath;
  String place;
  String comment;
  String description;
  String price;

  Activity(
      {required this.name,
      required this.time,
      required this.price,
      required this.logoPath,
      required this.symbolName,
      required this.photoPath,
      required this.place,
      this.comment = "",
      required this.description});
}

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 3));
  final DateTime _endDate = DateTime.now().add(const Duration(days: 20));
  final List<DateTime> _days = [];
  int _currentIndex = 0;

// exemple for list of activiies to test the activity list view
  // final List<Activity> activities = [
  //   Activity(
  //     name: "Vols",
  //     time: "14:00-14:45",
  //     price: "0€",
  //     logoPath: 'assets/images/Vol.svg',
  //     symbolName: 'Aéroport de Tunis',
  //     photoPath:
  //         'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
  //     place: 'Aéroport tunis carthage',
  //     description:
  //         'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
  //   ),
  //   Activity(
  //     name: "Hotles",
  //     time: "16:00-16:50",
  //     price: "0€",
  //     logoPath: 'assets/images/hottt.svg',
  //     symbolName: 'Royal Azur Hotel Thalassa',
  //     photoPath:
  //         'https://fwk.resabo.com/cr.fwk/images/hotels/Hotel-8905-20230102-095053.jpg',
  //     place: 'Hammamet, Tunisie Station touristique',
  //     description:
  //         'L’Hôtel Royal Azur Thalassa propose une de?couverte Tunisienne à travers une déambulation dans ses espaces à caractère culturel profond.',
  //   ),
  //   Activity(
  //     name: "Visites",
  //     time: "17:00-18:00",
  //     price: "28,51€",
  //     logoPath: 'assets/images/vis.svg',
  //     symbolName: 'Sidi Bou Said',
  //     photoPath:
  //         "https://travelfree.info/wp-content/uploads/2020/06/tunisia-2425441_1280-e1593516163383.jpg",
  //     place: "Tunisia-tunis",
  //     description:
  //         "You could be forgiven for thinking that you’d made the hop across the Med to the islands of the Greek Aegean as you enter the vibrant interior of Sidi Bou Said town, sat just 20 kilometers from bustling Tunis.Yep, the sky-blue and whitewashed color scheme here is more than reminiscent of towns in Santorini and Mykonos.However, this one’s interesting hues were actually started by the French musicologist Rodolphe d’Erlanger.",
  //   ),
  //   Activity(
  //     name: "Restaurants",
  //     time: "19:00",
  //     price: "0€",
  //     logoPath: 'assets/images/restt.svg',
  //     symbolName: 'Restaurant Dar El Jeld',
  //     photoPath:
  //         'https://www.sejours-tunisie.com/wp-content/uploads/2019/02/meilleurs-restaurants-tunis.jpg',
  //     place: 'Tunisie, Tunis',
  //     description:
  //         'Dar El Jeld : avec sa localisation atypique au milieu du souk de Tunis, cette demeure exceptionnelle reconvertit en restaurant chic et raffiné propose divers plats orientaux et tunisiens d’exception : généreux et goûteux, vous serez agréablement séduit !',
  //   ),
  //   Activity(
  //     name: "Activities",
  //     time: "10:00-12:30",
  //     price: "48,51€",
  //     logoPath: 'assets/images/mount.svg',
  //     symbolName: 'lle de Djerba',
  //     photoPath:
  //         'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/1b/31/caption.jpg?w=500&h=400&s=1',
  //     place: 'Par Djerba Explore',
  //     description: 'Ile de Djerba: excursion : une heure et demie en quad',
  //   ),
  // ];

  final List<Activity> activities = [
    Activity(
      name: "Restaurants",
      time: "19:00-20:00",
      price: "0€",
      logoPath: 'assets/images/restt.svg',
      symbolName: 'Restaurant Dar El Jeld',
      photoPath:
          'https://www.sejours-tunisie.com/wp-content/uploads/2019/02/meilleurs-restaurants-tunis.jpg',
      place: 'Tunisie, Tunis',
      description:
          'Dar El Jeld : avec sa localisation atypique au milieu du souk de Tunis, cette demeure exceptionnelle reconvertit en restaurant chic et raffiné propose divers plats orientaux et tunisiens d’exception : généreux et goûteux, vous serez agréablement séduit !',
    ),
    Activity(
      name: "Flights",
      time: "14:00-14:45",
      price: "0€",
      logoPath: 'assets/images/Vol.svg',
      symbolName: 'Aéroport de Tunis',
      photoPath:
          'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
      place: 'Aéroport tunis carthage',
      description:
          'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
    ),
    Activity(
      name: "Bus",
      time: "14:00-14:45",
      price: "0€",
      logoPath: 'assets/images/bus.svg',
      symbolName: 'Aéroport de Tunis',
      photoPath:
          'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
      place: 'Aéroport tunis carthage',
      description:
          'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
    ),
    Activity(
      name: "Hotels",
      time: "16:00-16:50",
      price: "0€",
      logoPath: 'assets/images/hottt.svg',
      symbolName: 'Royal Azur Hotel Thalassa',
      photoPath:
          'https://cdn2.tqsan.com/booking/royal-azur-thalasso-golf/Hotel-783-20170607-093132.jpg',
      place: 'Hammamet, Tunisie Station touristique',
      description:
          'L’Hôtel Royal Azur Thalassa propose une de?couverte Tunisienne à travers une déambulation dans ses espaces à caractère culturel profond.',
    ),
    Activity(
      name: "Visits",
      time: "17:00-18:00",
      price: "28,51€",
      logoPath: 'assets/images/vis.svg',
      symbolName: 'Sidi Bou Said',
      photoPath:
          "https://travelfree.info/wp-content/uploads/2020/06/tunisia-2425441_1280-e1593516163383.jpg",
      place: "Tunisia-tunis",
      description:
          "You could be forgiven for thinking that you’d made the hop across the Med to the islands of the Greek Aegean as you enter the vibrant interior of Sidi Bou Said town, sat just 20 kilometers from bustling Tunis.Yep, the sky-blue and whitewashed color scheme here is more than reminiscent of towns in Santorini and Mykonos.However, this one’s interesting hues were actually started by the French musicologist Rodolphe d’Erlanger.",
    ),
    Activity(
      name: "Visits",
      time: "10:00-14:00",
      price: "28,51€",
      logoPath: 'assets/images/vis.svg',
      symbolName: 'Excursion Stars Wars',
      photoPath:
          "https://unsacsurledos.com/wp-content/uploads/2016/12/PC051057.jpg",
      place: "Tunisia-Gabes",
      description:
          "Quand l’histoire nous emporte de l’autre côté de l’écran ! Après la découverte des décors de Game of Thrones en Irlande du Nord, nous voici dans ceux de Star Wars en Tunisie. Au milieu du désert, nous sommes partis explorer la planète Tatooine, sur les traces de Anakin, Luke, Obi-Wan, Darth et Vador. Voici notre aventure en mode Jedi et toutes les informations pour visiter les lieux de tournage Star Wars en Tunisie.Star Wars en Tunisie: Star Wars, une saga qu’on ne présente plus ! Qu’on soit fan ou pas, tout le monde connait le souffle rauque de Darth Vador, le cri de Luke, le bikini de Leia et la dégaine de Han Solo. Mais peu savent où les épisodes ont été tournés !C’est dans le sud de la Tunisie, au milieu des étendues désertiques, que des passages de la trilogie originale (épisodes IV – V – VI) et de la « Prélogie » (épisodes I – II – III) ont été tournés, tout spécialement les épisodes I (tourné en 1997, sorti en 1999), II (tourné en 2000, sorti en 2002), III (tourné en 2003, sorti en 2005) et IV (tourné en 1976, sorti en 1977) ,' tous ceux qui concernent la planete Tatooine, planete natale du mignon petit blondinet Anakin Skywalker.",
    ),
    Activity(
      name: "Activities",
      time: "10:00-12:30",
      price: "48,51€",
      logoPath: 'assets/images/mount.svg',
      symbolName: 'lle de Djerba',
      photoPath:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/1b/31/caption.jpg?w=500&h=400&s=1',
      place: 'Par Djerba Explore',
      description:
          'Essayez le quad à Djerba pour un circuit aventureux et passionnant, adapté aux débutants, aux cyclistes expérimentés et aux groupes. Parcourez des paysages incroyables remplis d'
          "eucalyptus et de figuiers de Barbarie avec des machines de haute qualité et avec un guide spécialisé.",
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
    int numBoxes = 3 + DateTime.now().millisecond % 8;

    // Loop through the number of boxes and add them to the list
    for (int i = 0; i < numBoxes; i++) {
      for (int j = 0; j < activities.length; j++) {
        Activity index = activities[j];
        // Generate a random color for each box , 
        Random random = Random();
        Color boxColor = Color.fromARGB(
            255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
        // Generate a random height for each box between 50 and 150
        double boxHeight = 240.0 /*+ DateTime.now().millisecond % 100*/;

//Box's Detail

        // Build the box widget
        Widget box = GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoxDescriptionPage(
                  activity: index,
                ),
              ),
            );
          },
          child: Container(
            height: boxHeight,
            decoration: BoxDecoration(
              color: boxColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.0),
            ), 
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      index.time,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        ClipOval(
                          child: SvgPicture.asset(
                            index.logoPath,
                            fit: BoxFit.cover,
                            height: 40.0,
                          ),
                        ),
                        const SizedBox(width: 8, height: 16),
                        Text(
                          index.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ClipOval(
                          child: Image.network(
                            index.photoPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 6, height: 80),
                        Text(
                          index.symbolName,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            'assets/images/place.svg',
                            width: 13,
                            height: 13,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 26, width: 10),
                        Text(
                          index.place,
                          style: const TextStyle(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1D5DB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _showCommentDialog(context, index);
                          },
                          child: const Text(
                            "Add Comment",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          index.comment,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        // Add the box widget to the list of boxes
        boxes.add(box);
      }
    }
    return boxes;
  }

  Widget _buildDay(DateTime day) {
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
    bool isSelected = _currentIndex == _days.indexOf(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = _days.indexOf(day);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 241, 210, 231)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            "$dayOfWeek ${day.day}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: (day == _currentIndex) ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaysList() {
    return SizedBox(
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

  /*List<String> boxDescriptions = [
    'Box 1 description',
    'Box 2 description',
    'Box 3 description'
  ];*/

  Widget _buildPlanContent() {
    DateTime currentDay = _days[_currentIndex];
    // Generate a list of boxes with different colors and contents
    List<Widget> boxes = _buildBoxes();
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (BuildContext context, int index) {
                /*return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoxDescriptionPage(
                            description: boxDescriptions[index]),
                      ),
                    );
                  },*/
                // child: Padding(
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: boxes[index],
                  //),
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
    final start = DateFormat("MMM dd, yyyy").format(_startDate);
    final end = DateFormat("MMM dd, yyyy").format(_endDate);
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Planning 1',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: const TextStyle(
                fontSize: 16.0,
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
//               leading: const Icon(Icons.category),
//               title: const Text('Activié/Visite'),
//               onTap: () {
//                 // Navigate to activites screen when pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const VisitesScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

void _showCommentDialog(BuildContext context, Activity activity) {
  TextEditingController commentController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: "Enter comment"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              activity.comment = commentController.text;
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}

List<String> boxDescriptions = [
  'Box 1 description',
  'Box 2 description',
  'Box 3 description'
];

class BoxDescriptionPage extends StatelessWidget {
  final Activity activity;

  const BoxDescriptionPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activity.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),

        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(activity.photoPath),
            const SizedBox(height: 16),
            /* Text(place.time),*/

            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 158, 233)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    activity.time,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
                const SizedBox(width: 146),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 158, 233)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Price : ${activity.price}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              activity.symbolName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            /*SizedBox(height: 8),
          Text(place.address),*/

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
                  activity.place,
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
            Text(activity.description),
            const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {},
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all<Color>(
            //             const Color.fromARGB(255, 252, 56, 121)),
            //       ),
            //       child: const Text("Accept",
            //           style: TextStyle(color: Colors.white)),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {},
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all<Color>(
            //             const Color.fromARGB(255, 214, 208, 208)),
            //       ),
            //       child: const Text("Decline",
            //           style: TextStyle(color: Colors.black)),
            //     ),
            //   ],
            // ),

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
                                      Image.network(activity.photoPath).image,
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
        // ),
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
