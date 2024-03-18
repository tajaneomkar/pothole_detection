import 'package:flutter/material.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';
import 'package:pothole_detection/utils/common/date_picker_text_field_widget.dart';
import 'package:pothole_detection/utils/common/file_picker_widget.dart';

class UserPanelRegisterComplaint extends StatefulWidget {
  const UserPanelRegisterComplaint({super.key});

  @override
  State<UserPanelRegisterComplaint> createState() =>
      _UserPanelRegisterComplaintState();
}

class _UserPanelRegisterComplaintState
    extends State<UserPanelRegisterComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcPrimaryColorDark,
        title: const Text('FILL THE FORM',
            style: TextStyle(color: appWhite, letterSpacing: 1.2)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: appWhite),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20),
            const AppInputField(
              label: 'Name',
              hint: 'Enter your Name',
            ),
            const SizedBox(height: 20),
            const AppInputField(
              label: 'Email-Id',
              hint: 'Enter your Email-Id',
            ),
            const SizedBox(height: 20),
            const AppInputField(
              label: 'Contact Number',
              hint: 'Enter your Contact Number',
            ),
            const SizedBox(height: 20),
            const DatePickerFormField(
              label: 'Date',
              hint: 'Select Date',
            ),
            const SizedBox(height: 20),
            const AppInputField(
              label: 'Address',
              hint: 'Enter Address of Pothole',
            ),
            const SizedBox(height: 20),
            const AppInputField(
              maxLines: 6,
              label: 'Description',
              hint: 'Enter your description',
            ),
            const SizedBox(height: 20),
            FilePickerButton(),
            const SizedBox(height: 20),
            CustomButton(
                textColor: appWhite,
                isLoading: true,
                buttonColor: kcPrimaryColorDark,
                height: 45,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: kcPrimaryColor,
                      duration: Duration(seconds: 1),
                      content: Text('Your Complaint Submitted Succesfully'),
                    ),
                  );
                },
                text: 'Submit'),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
