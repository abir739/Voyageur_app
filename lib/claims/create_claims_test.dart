import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

enum ComplaintOption {
  photo,
  comments,
  feedback,
  moodFeedback,
}

class CreateComplaintsScreen extends StatefulWidget {
  const CreateComplaintsScreen({Key? key}) : super(key: key);

  @override
  _CreateComplaintsScreenState createState() => _CreateComplaintsScreenState();
}

class _CreateComplaintsScreenState extends State<CreateComplaintsScreen> {
  List<File> _imageFiles = [];
  List<String> _sentences = [];
  ComplaintOption _selectedOption = ComplaintOption.photo;
  TextEditingController _sentenceController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _feedbackController = TextEditingController();
  double _rating = 0.0;
  String _moodFeedback = '';

  Future<void> _showRatingDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate your experience'),
          content: RatingBar(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star),
              half: const Icon(Icons.star_half),
              empty: const Icon(Icons.star_border),
            ),
            onRatingUpdate: (double rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFiles.add(File(pickedImage.path));
        _sentences.add('');
      });
    } else {
      print('No image selected');
    }
  }

  void _createComplaint(ComplaintOption option) {
    switch (option) {
      case ComplaintOption.photo:
        if (_imageFiles.isNotEmpty && _sentences.isNotEmpty) {
          for (int i = 0; i < _imageFiles.length; i++) {
            print('Sending photo complaint: ${_imageFiles[i].path}');
            print('Sentence: ${_sentences[i]}');
            // Perform your API call or send the data via email here
            // You can access the _imageFiles[i] file and _sentences[i] text to send them
            // Use your desired method to send the data based on your requirements
          }
          // Reset the selected photos and sentences after sending
          setState(() {
            _imageFiles.clear();
            _sentences.clear();
          });
        } else {
          print('Please select at least one photo and enter a sentence');
        }
        break;
      // Other cases...
      case ComplaintOption.comments:
        if (_commentController.text.isNotEmpty) {
          print('Creating comment: ${_commentController.text}');
          // Perform your API call or send the comment via email here
          // You can access the comment using _commentController.text
          // Use your desired method to send the comment based on your requirements
          // Reset the comment field after sending
          setState(() {
            _commentController.clear();
          });
        } else {
          print('Please enter a comment');
        }
        break;

      case ComplaintOption.feedback:
        if (_feedbackController.text.isNotEmpty) {
          print('Providing feedback: ${_feedbackController.text}');
          // Perform your API call or send the feedback via email here
          // You can access the feedback using _feedbackController.text
          // Use your desired method to send the feedback based on your requirements
          // Reset the feedback field after sending
          setState(() {
            _feedbackController.clear();
          });
        } else {
          print('Please enter feedback');
        }
        break;
      case ComplaintOption.moodFeedback:
        print('Rating: $_rating');
        print('Mood feedback: $_moodFeedback');
        // Perform your API call or processing based on the rating and mood feedback
        // You can access the rating using _rating and the mood feedback using _moodFeedback
        // Use your desired method to send or process the data based on your requirements
        // Reset the rating and mood feedback after sending or processing
        setState(() {
          _rating = 0.0;
          _moodFeedback = '';
        });
        break;
    }
    // Show success dialog after sending the complaint
    // _showSuccessDialog(context);
    _showSuccessDialog(context, () {});
  }

  // void _showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.green, // Set the background color to green
  //         content: Row(
  //           children: <Widget>[
  //             const Icon(
  //               Icons.check_circle,
  //               color: Colors.white,
  //               size: 40.0,
  //             ),
  //             const SizedBox(width: 16.0),
  //             const Text(
  //               'Complaints sent successfully!',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showSuccessDialog(BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.SUCCES,
      title: 'Success!',
      desc: 'Complaints sent successfully!',
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green.shade900,
      btnOkOnPress: onOkPress,
    ).show();
  }

  @override
  void dispose() {
    _sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Create Complaints'),
      // ),
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
            const Text('Create Complaints'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select an option to create a complaint:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 26.0),
            ListTile(
              title: const Text('Take a photo and send it'),
              leading: Radio<ComplaintOption>(
                value: ComplaintOption.photo,
                groupValue: _selectedOption,
                onChanged: (ComplaintOption? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
                activeColor: Color(0xFF353657),
              ),
              onTap: () {
                _takePhoto();
              },
            ),
            ListTile(
              title: const Text('Create comments'),
              leading: Radio<ComplaintOption>(
                value: ComplaintOption.comments,
                groupValue: _selectedOption,
                onChanged: (ComplaintOption? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
                activeColor: Color(0xFF353657),
              ),
              onTap: () {
                setState(() {
                  _selectedOption = ComplaintOption.comments;
                });
              },
              subtitle: TextField(
                controller: _commentController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Enter your comment',
                ),
              ),
            ),

            // ListTile(
            //   title: const Text('Provide feedback'),
            //   leading: Radio<ComplaintOption>(
            //     value: ComplaintOption.feedback,
            //     groupValue: _selectedOption,
            //     onChanged: (ComplaintOption? value) {
            //       setState(() {
            //         _selectedOption = value!;
            //       });
            //     },
            //   ),
            //   onTap: () {
            //     setState(() {
            //       _selectedOption = ComplaintOption.feedback;
            //     });
            //     _showRatingDialog();
            //   },
            //   subtitle: TextField(
            //     controller: _feedbackController,
            //     onChanged: (value) {},
            //     decoration: const InputDecoration(
            //       hintText: 'Enter your feedback',
            //     ),
            //   ),
            // ),
            ListTile(
              title: const Text('Mood feedback'),
              leading: Radio<ComplaintOption>(
                value: ComplaintOption.moodFeedback,
                groupValue: _selectedOption,
                onChanged: (ComplaintOption? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
                activeColor: Color(0xFF353657),
              ),
              onTap: () {
                setState(() {
                  _selectedOption = ComplaintOption.moodFeedback;
                });
              },
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rate your feedback:'),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (double rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Provide  feedback:'),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _moodFeedback = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your feedback !',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _imageFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Image.file(_imageFiles[index]),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: _sentenceController,
                        onChanged: (value) {
                          setState(() {
                            _sentences[index] = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter a sentence',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  );
                },
              ),
            ),
            // To send the selected photos and their corresponding sentences when the "Create Complaint" button is tapped,
            //  we will use of an API call or a suitable method for sending the data.
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF353657),
              ),
              onPressed: () {
                _createComplaint(_selectedOption);
              },
              child: const Text('Create Complaint'),
            )
          ],
        ),
      ),
    );
  }
}
