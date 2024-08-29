import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class MyHomePage1 extends StatelessWidget {
  File? _image;

  MyHomePage1({super.key});

  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageDisplayPage(image: _image!),
        ),
      );
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _image == null
            //     ? const Text('No image selected.')
            //     : Image.file(_image!),
            // const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _getImage(context),
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDisplayPage extends StatelessWidget {
  final File image;

  const ImageDisplayPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image'),
      ),
      body: Center(
        child: kIsWeb
            ? Image.network(
                image.path,
                width: 300.0, // Adjust width as needed
                height: 300.0, // Adjust height as needed
              )
            : Image.file(image),
      ),
    );
  }
}