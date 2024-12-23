import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor/image_editor.dart';
import 'dart:io';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  File? _image;

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Apply a grayscale filter as an example
  Future<void> _applyGrayscaleFilter() async {
    if (_image == null) return;

    final imageEditorOption = ImageEditorOption()
      ..addOption(ColorOption.grayscale());

    final editedImage = await ImageEditor.editImage(
      image: _image!.readAsBytesSync(),
      imageEditorOption: imageEditorOption,
    );

    setState(() {
      _image = File.fromRawPath(editedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Screen"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          if (_image != null)
            Expanded(
              child: Image.file(
                _image!,
                fit: BoxFit.contain,
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text("No image selected"),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Pick Image"),
              ),
              ElevatedButton(
                onPressed: _applyGrayscaleFilter,
                child: const Text("Apply Grayscale"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
