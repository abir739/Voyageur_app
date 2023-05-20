import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateComplaintsScreen extends StatefulWidget {
  const CreateComplaintsScreen({super.key});

  @override
  _CreateComplaintsScreenState createState() => _CreateComplaintsScreenState();
}

class _CreateComplaintsScreenState extends State<CreateComplaintsScreen> {
  String _selectedOption = '';
  late File _image;

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _createComplaint(String option) {
    // Logic for creating the complaint based on the selected option
    switch (option) {
      case 'photo':
        if (_image != null) {
          // Logic for sending the photo complaint
          // Access the `_image` file and send it
          // You can use an API call or send it via email, depending on your requirements
          print('Sending photo complaint: ${_image.path}');
        } else {
          print('No photo selected');
        }
        break;
      case 'comments':
        // Logic for creating comments
        break;
      case 'feedback':
        // Logic for providing feedback
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Complaints'),
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
            const SizedBox(height: 16.0),
            ListTile(
              title: const Text('Take a photo and send it'),
              leading: Radio(
                value: 'photo',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String;
                  });
                },
              ),
              onTap: () {
                _takePhoto();
              },
            ),
            ListTile(
              title: const Text('Create comments'),
              leading: Radio(
                value: 'comments',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Provide feedback'),
              leading: Radio(
                value: 'feedback',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _createComplaint(_selectedOption);
              },
              child: const Text('Create Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}
