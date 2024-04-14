import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_register_bloc/user_panel_register_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<UserPanelRegisterBloc>(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kcPrimaryColorDark,
            title: const Text('FILL THE FORM',
                style: TextStyle(color: appWhite, letterSpacing: 1.2)),
            centerTitle: true,
            iconTheme: const IconThemeData(color: appWhite),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const UserPanel(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          body: BlocConsumer<UserPanelRegisterBloc, UserPanelRegisterState>(
            listener: (context, state) {
              if (state is UserPanelRegisterLoaded) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const UserPanel(),
                  ),
                );
              } else if (state is UserPanelRegisterError) {
                serviceLocator<SharedPreferencesService>()
                    .clearLoginData(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
                    ),
                  ),
                );
              } else if (state is UploadImageUserPanelSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: kcPrimaryColor,
                    duration: Duration(seconds: 1),
                    content: Text('Your Image Upload Successfully'),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is UserPanelRegisterLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 20),
                    AppInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      label: 'Name',
                      hint: 'Enter your Name',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .nameController,
                    ),
                    const SizedBox(height: 20),
                    AppInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email-Id';
                        }
                        return null;
                      },
                      label: 'Email-Id',
                      hint: 'Enter your Email-Id',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .emailController,
                    ),
                    const SizedBox(height: 20),
                    AppInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Contact Number';
                        }
                        return null;
                      },
                      label: 'Contact Number',
                      hint: 'Enter your Contact Number',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .contactController,
                    ),
                    const SizedBox(height: 20),
                    DatePickerFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                      label: 'Date',
                      hint: 'Select Date',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .dateController,
                    ),
                    const SizedBox(height: 20),
                    AppInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Address of Pothole';
                        }
                        return null;
                      },
                      label: 'Address',
                      hint: 'Enter Address of Pothole',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .addressController,
                    ),
                    const SizedBox(height: 20),
                    AppInputField(
                      maxLines: 6,
                      label: 'Description',
                      hint: 'Enter your description',
                      controller:
                          BlocProvider.of<UserPanelRegisterBloc>(context)
                              .descriptionController,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<UserPanelRegisterBloc, UserPanelRegisterState>(
                      builder: (context, state) {
                        if (state is UploadImageUserPanelLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const FilePickerButton();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        textColor: appWhite,
                        isLoading:
                            state is UserPanelRegisterLoading ? true : false,
                        buttonColor: kcPrimaryColorDark,
                        height: 45,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<UserPanelRegisterBloc>(context)
                                .add(UserPanelRegisterInitialEvent());
                          }
                        },
                        text: 'Submit'),
                    const SizedBox(height: 20),
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
