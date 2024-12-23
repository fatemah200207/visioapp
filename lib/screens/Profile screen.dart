import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _profileImage; // Holds the selected profile image
  String? _savedImagePath; // Holds the saved file path

  @override
  void initState() {
    super.initState();
    _loadSavedImage(); // Load the saved image path
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedImagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = image;
      });

      // Save the image path
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', image.path);

      // Update the saved path
      setState(() {
        _savedImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            GestureDetector(
              onTap: _pickImage, // Opens the image picker when tapped
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _savedImagePath != null
                    ? FileImage(File(_savedImagePath!))
                    : const AssetImage('assets/default_profile.png')
                as ImageProvider, // Fallback to a default profile image
                child: _savedImagePath == null
                    ? const Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            // Name and Username
            const Text(
              'Amy Young',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Amy245',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            // Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.calendar_today, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        '12/12/2003',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(Icons.phone, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        '01120551806',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(Icons.email, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Amyyoung201333@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Favorites
                  Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Favorites',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Log Out
                  GestureDetector(
                    onTap: () {
                      // Add your logout functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Log Out',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
