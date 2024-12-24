import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visioapp/screens/FAQ.dart';
import 'package:visioapp/screens/Profile%20screen.dart';
import 'package:visioapp/screens/folder%20screen.dart';
import 'package:visioapp/screens/help%20screeen.dart';
import 'package:visioapp/screens/login%20screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> folderNames = [
    'Photos',
    'Videos',
    'Documents',
    'Projects',
    'Music',
    'Work',
  ];

  @override
  void initState() {
    super.initState();
    _loadFolders(); // Load the saved folder names when the app starts
  }

  // Function to load folder names from SharedPreferences
  _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      folderNames = prefs.getStringList('folders') ?? folderNames; // Load saved folders or use default
    });
  }

  // Function to save folder names to SharedPreferences
  _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('folders', folderNames); // Save the folder list
  }

  // Function to clear folder names from SharedPreferences
  _clearFolders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      folderNames = []; // Clear the folder list
    });
    prefs.remove('folders'); // Remove the stored folder list from SharedPreferences
  }

  // Function to delete a folder
  _deleteFolder(int index) async {
    setState(() {
      folderNames.removeAt(index); // Remove the folder from the list
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('folders', folderNames); // Save the updated folder list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Folder "${folderNames[index]}" deleted')),
    );
  }

  void _addNewFolder(String folderName) {
    setState(() {
      folderNames.add(folderName);
      _saveFolders(); // Save the updated folder list
    });
  }

  void _showAddFolderDialog() {
    String newFolderName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Create New Folder'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter folder name'),
            onChanged: (value) {
              newFolderName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newFolderName.isNotEmpty) {
                  _addNewFolder(newFolderName);
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text('FAQ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FAQPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual login page widget
                      (route) => false, // Clear all routes
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'My Studio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 20), // Spacer for AppBar height
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'My Folders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: folderNames.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FolderPage(
                                    folderName: folderNames[index],
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              // Show a confirmation dialog to delete the folder
                              _showDeleteFolderDialog(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  folderNames[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFB2EBF2),
        onPressed: _showAddFolderDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to show the delete folder confirmation dialog
  void _showDeleteFolderDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Folder'),
          content: Text('Are you sure you want to delete "${folderNames[index]}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteFolder(index); // Delete the folder
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
