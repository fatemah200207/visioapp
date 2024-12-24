import 'package:flutter/material.dart';
import 'package:visioapp/screens/file%20screen.dart';
//import 'package:visioapp/screens/file_screen.dart'; // Ensure the correct path to FileScreen is imported

class FolderPage extends StatelessWidget {
  final String folderName;

  const FolderPage({required this.folderName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          folderName, // Display folder name in AppBar
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to FileScreen
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FileScreen(),
                        ),
                      );*/
                    },
                    child: const Text('Add Files'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
