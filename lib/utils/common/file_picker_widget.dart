import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pothole_detection/config/router/app_router.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_register_bloc/user_panel_register_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';

class FilePickerButton extends StatefulWidget {
  const FilePickerButton({super.key});

  @override
  State<FilePickerButton> createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOptionsDialog(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle),
        child: BlocProvider.of<UserPanelRegisterBloc>(
                  context,
                  listen: true,
                ).imageBytes !=
                null
            ? Image.file(BlocProvider.of<UserPanelRegisterBloc>(
                  context,
                  listen: true,
                ).imageBytes ??
                File(""))
            : Column(
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

  void showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Choose an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  openCamera(context);
                  serviceLocator<AppRouter>().maybePop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  openFilePicker(context);
                  serviceLocator<AppRouter>().maybePop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        BlocProvider.of<UserPanelRegisterBloc>(context)
            .add(UploadImageUserPanelInitialEvent(File(pickedFile.path)));
      } else {
        print('User canceled operation');
      }
    } catch (e) {
      print('Error capturing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error capturing image. Please try again later.'),
        ),
      );
    }
  }

  Future<void> openFilePicker(BuildContext context) async {
    await getImage(context, ImageSource.gallery);
  }

  Future<void> openCamera(BuildContext context) async {
    await getImage(context, ImageSource.camera);
  }
}
