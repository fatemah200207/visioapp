// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
//
// class FileScreen extends StatefulWidget {
//   @override
//   _FileScreenState createState() => _FileScreenState();
// }
//
// class _FileScreenState extends State<FileScreen> {
//   File? _imageFile;
//
//   // Pick an image from the gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Crop the selected image
//   Future<void> _cropImage() async {
//     if (_imageFile == null) return;
//
//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: _imageFile!.path,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9,
//       ],
//       androidUiSettings: AndroidUiSettings(
//         toolbarTitle: 'Cropper',
//         toolbarColor: Colors.deepOrange,
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.square,
//         lockAspectRatio: false,
//       ),
//
//     );
//
//     if (croppedFile != null) {
//       setState(() {
//         _imageFile = File(croppedFile.path);  // Assign the cropped file to _imageFile
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Cropper'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _imageFile != null
//                 ? Image.file(_imageFile!)  // Display the cropped image
//                 : Text('No image selected.'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _cropImage,
//               child: Text('Crop Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
