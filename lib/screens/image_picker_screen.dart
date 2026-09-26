import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        _images = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Gallery'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _images.isEmpty
                  ? const Center(child: Text('No Images Yet'))
                  : ListView.builder(
                      itemCount: _images.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(_images[index].path)),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: _pickImages,
                child: const Text('Pick Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
