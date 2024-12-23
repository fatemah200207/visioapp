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
  String? _savedImagePath; // Holds the saved file path

  @override
  void initState() {
    super.initState();
    _loadSavedImage(); // Load the saved image path on app start
  }

  /// Load the saved image path from SharedPreferences
  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedImagePath = prefs.getString('profileImagePath');
    });
  }

  /// Pick an image using the ImagePicker
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
    );

    if (image != null) {
      setState(() {
        _savedImagePath = image.path;
      });

      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', image.path);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GestureDetector(
                onTap: _pickImage, // Opens the image picker when tapped
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300], // Placeholder background color
                  backgroundImage: _savedImagePath != null
                      ? FileImage(File(_savedImagePath!)) // Show saved image
                      : null, // No default image
                  child: _savedImagePath == null
                      ? const Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black,
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              // Profile Details
              const Text(
                'Amy Young',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Amy245',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const Spacer(), // Pushes content upward and ensures the layout stretches
            ],
          ),
        ),
      ),
    );
  }
}
