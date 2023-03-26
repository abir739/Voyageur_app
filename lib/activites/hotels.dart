import 'package:flutter/material.dart';
import 'package:voyageur_app/notification/notification.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotelPage extends StatelessWidget {
  final String image;
  final String time;
  final String fullName;
  final int rating;
  final String address;
  final String comment;

  HotelPage(
      {required this.image,
      required this.time,
      required this.fullName,
      required this.rating,
      required this.address,
      this.comment = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SvgPicture.asset(
                            'assets/images/Logo.svg',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          'Hôtels',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 260.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 163, 97, 175)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '$rating / 5.0',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 8, width: 20),
                      Container(
                        child: Image.asset(
                          'assets/images/Icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8, width: 8),
                      Text(
                        address,
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 8, 8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Divider(
                    color: Color.fromARGB(255, 189, 184, 184),
                    thickness: 2.0,
                  ),
                  SizedBox(height: 126.0),
                  CommentSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;

  HotelListScreen({required this.hotels});

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
      body: PageView.builder(
        itemCount: hotels.length,
        itemBuilder: (BuildContext context, int index) {
          final hotel = hotels[index];
          return HotelPage(
            image: hotel['image'],
            time: hotel['time'],
            fullName: hotel['fullName'],
            rating: hotel['rating'],
            address: hotel['address'],
          );
        },
      ),
    );
  }
}

void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.local_hotel_outlined),
              title: const Text('Hotels'),
              onTap: () {
                // Navigate to hotels screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelListScreen(
                            hotels: [
                              {
                                'image': 'assets/images/hotel-img.png',
                                'time': '15:30-16:00',
                                'fullName': 'Hotel Carlton',
                                'rating': 4,
                                'address': '123 Main St, Anytown USA',
                              },
                              {
                                'image': 'hotel_b.jpg',
                                'time': '45 minutes',
                                'fullName': 'Hotel B Full Name',
                                'rating': 3,
                                'address': '456 Oak St, Anycity USA',
                              },
                              // Add more hotels here...
                            ],
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Restaurants'),
              onTap: () {
                // Navigate to restaurants screen when pressed
                Navigator.pushNamed(context, '/restaurants');
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Activié/Visite'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.pushNamed(context, '/Visite');
              },
            ),
          ],
        ),
      );
    },
  );
}

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final List<String> comments = [];

  final TextEditingController commentController = TextEditingController();

  void addComment() {
    final comment = commentController.text.trim();

    if (comment.isNotEmpty) {
      setState(() {
        comments.add(comment);
        commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '   Comments',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return Container(
              height: 163,
              width: 352,
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(comment),
            );
          },
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: '     Enter a comment',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: addComment,
              child: Text('Add Comment'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF4F46E5)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
