import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      // Handle the case when no image is selected or captured.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat vs Dog"),
        actions: [
          IconButton(
              icon: Icon(Icons.photo),
              onPressed: () => pickImage(ImageSource.gallery)
          ),

          IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => pickImage(ImageSource.camera)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Preview
            Expanded(
              child: _selectedImage != null
                  ? Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
                  : Center(
                child: Text(
                  "No image selected.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Buttons for Picking Image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo),
                  label: const Text("Gallery"),
                ),
                ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
