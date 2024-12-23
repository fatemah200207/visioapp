import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final int index;

  const FolderPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.folder,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                'Contents of Folder ${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to add files or perform folder-specific actions here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feature coming soon for Folder ${index + 1}!')),
                  );
                },
                child: const Text('Add Files'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
