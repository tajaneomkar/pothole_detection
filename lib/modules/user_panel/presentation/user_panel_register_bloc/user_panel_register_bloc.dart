import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/user_panel/data/model/register_user_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/upload_img_user_response.dart';
import 'package:pothole_detection/modules/user_panel/domain/usecases/user_panel_usecases.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/network/custom_exception.dart';

part 'user_panel_register_event.dart';
part 'user_panel_register_state.dart';

class UserPanelRegisterBloc
    extends Bloc<UserPanelRegisterEvent, UserPanelRegisterState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  UploadImgUserResponse? uploadImgUserResponse;
  File? imageBytes;

  UserPanelRegisterBloc() : super(UserPanelRegisterInitial()) {
    on<UserPanelRegisterEvent>((event, emit) {});

    on<UserPanelRegisterInitialEvent>(
      (event, emit) async {
        emit(UserPanelRegisterLoading());

        final useCase = serviceLocator<RegisterUserUseCase>();
        final response = await useCase.invoke(RegisterUserRequestModel(
          address: addressController.text,
          assignee: "",
          date: dateController.text,
          description: descriptionController.text,
          email: emailController.text,
          fileID: uploadImgUserResponse?.fileId ?? "",
          name: nameController.text,
          phoneNo: contactController.text,
          status: "pending",
          userId: serviceLocator<SharedPreferencesService>().userID,
        ));

        if (response.isLeft) {
          emit(UserPanelRegisterError(errorMessage: "Failure!"));
        } else {
          try {
            final data = response.right;

            if (data != null) {
              emit(UserPanelRegisterLoaded());
            } else {
              emit(UserPanelRegisterError(errorMessage: "No Data Available!"));
            }
          } catch (e) {
            emit(UserPanelRegisterError(errorMessage: 'An error occurred: $e'));
          }
        }
      },
    );
    on<UploadImageUserPanelInitialEvent>(
      (event, emit) async {
        emit(UploadImageUserPanelLoading());
        try {
          // Call your API passing the imagePath
          final uploadImageUserUseCase =
              serviceLocator<UploadImageUserUseCase>();
          final response = await uploadImageUserUseCase.invoke(event.file);

          if (response.isLeft) {
            emit(UploadImageUserPanelError(errorMessage: "Failure!!"));
          } else {
            uploadImgUserResponse =
                UploadImgUserResponse.fromJson(jsonDecode(response.right));

            if (uploadImgUserResponse != null) {
              imageBytes = event.file;
              print("done");
              emit(UploadImageUserPanelSuccess());
            } else {
              emit(UploadImageUserPanelError(
                  errorMessage: "Failed to upload image!"));
            }
          }
        } catch (e) {
          if (e is UnauthorizedException) {
            emit(NavigateToLoginPageEvent());
          } else {
            emit(UploadImageUserPanelError(
                errorMessage: 'An error occurred: $e'));
          }
        }
      },
    );
  }
}
