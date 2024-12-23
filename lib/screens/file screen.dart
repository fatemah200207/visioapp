import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart'; // Ensure correct import

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  List<String> imageFiles = [
    'assets/images/sample1.jpg',
    'assets/images/sample2.jpg',
    'assets/images/sample3.jpg',
  ];

  Future<void> _editImage(String imagePath) async {
    try {
      // Example: Navigating to the editor
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProImageEditorScreen(
            imagePath: imagePath, // Pass the path to the editor
          ),
        ),
      );

      if (result != null) {
        print('Editing completed, new image path: $result');
        // Update state if necessary
      } else {
        print('Editing canceled');
      }
    } catch (e) {
      print('Error during editing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Screen'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: imageFiles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _editImage(imageFiles[index]),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imageFiles[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Mock implementation of ProImageEditorScreen
class ProImageEditorScreen extends StatelessWidget {
  final String imagePath;

  const ProImageEditorScreen({required this.imagePath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Image Editor'),
      ),
      body: Center(
        child: Text('Editing image: $imagePath'),
      ),
    );
  }
}
