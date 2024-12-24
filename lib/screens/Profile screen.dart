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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedImage(); // Load the saved image path on app start
    _loadSavedData(); // Load saved data
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedImagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _birthdateController.text = prefs.getString('birthdate') ?? '';
    });
  }

  Future<void> _saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
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
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _savedImagePath != null
                          ? FileImage(File(_savedImagePath!))
                          : null,
                      child: _savedImagePath == null
                          ? const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.black,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 40), // Added extra space below the image
                  Padding(
                    padding: const EdgeInsets.only(top: 20), // Adjust the top padding
                    child: Column(
                      children: [
                        // Username
                        _buildProfileField(
                          icon: Icons.person,
                          label: 'Username',
                          controller: _usernameController,
                          saveKey: 'username',
                        ),
                        const SizedBox(height: 15),
                        // Birthdate
                        _buildProfileField(
                          icon: Icons.calendar_today,
                          label: 'Birthdate',
                          controller: _birthdateController,
                          saveKey: 'birthdate',
                        ),
                        const SizedBox(height: 15),
                        // Phone
                        _buildProfileField(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          controller: _phoneController,
                          saveKey: 'phone',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15),
                        // Email
                        _buildProfileField(
                          icon: Icons.email,
                          label: 'Email',
                          controller: _emailController,
                          saveKey: 'email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String saveKey,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Colors.black54),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(color: Colors.black54),
              border: InputBorder.none, // No underline
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black),
            onChanged: (value) {
              _saveData(saveKey, value); // Save data whenever the field changes
            },
          ),
        ),
      ],
    );
  }
}
