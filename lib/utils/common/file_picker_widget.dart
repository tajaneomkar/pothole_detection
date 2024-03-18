import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOptionsDialog(context);
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle),
        child: Column(
          children: [
            Icon(Icons.file_copy, size: 70, color: Colors.grey.shade300),
            const SizedBox(height: 10),
            const Text(
              'Please attach a photo of the pothole.',
              overflow: TextOverflow.visible,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> openFilePicker(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Do something with the picked file
        print('File picked: ${result.files.single.name}');
      } else {
        // User canceled the picker
        print('User canceled file picking');
      }
    } catch (e) {
      // Handle errors gracefully
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking file. Please try again later.'),
        ),
      );
    }
  }

  static Future<void> openCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image != null) {
        // Do something with the captured image
        print('Image captured: ${image.path}');
      } else {
        // User canceled capturing
        print('User canceled capturing');
      }
    } catch (e) {
      // Handle errors gracefully
      print('Error capturing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error capturing image. Please try again later.'),
        ),
      );
    }
  }
}

void showOptionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Choose an Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                FilePickerButton.openCamera(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                FilePickerButton.openFilePicker(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
