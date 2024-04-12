import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_update_status_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/get_pot_hole_by_admin_uid_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/get_pot_hole_by_admin_uid_response_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/verify_pothole_img_request.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/verify_pothole_img_response.dart';
import 'package:pothole_detection/modules/admin_panel/domain/usecases/admin_panel_usecases.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/network/custom_exception.dart';

part 'admin_detail_view_event.dart';
part 'admin_detail_view_state.dart';

class AdminDetailViewBloc
    extends Bloc<AdminDetailViewEvent, AdminDetailViewState> {
  TextEditingController statusController = TextEditingController();
  TextEditingController assignContractorController = TextEditingController();
  AdminDetailViewBloc() : super(AdminDetailViewInitial()) {
    on<AdminDetailViewEvent>((event, emit) {});

    on<AdminPanelDetailsInitialEvent>((event, emit) async {
      emit(AdminPanelDetailsLoadingState());
      final detailsUseCase = serviceLocator<GetPotHoleByAdminUIdUseCase>();
      final response = await detailsUseCase
          .invoke(GetPotHoleInformationByAdminUIdRequestModel(
        infoID: event.id,
      ));

      if (response.isLeft) {
        emit(AdminPanelDetailsErrorState(errorMessage: "Failure!"));
      } else {
        try {
          final data = GetPotHoleInformationByAdminUIdResponseModel.fromJson(
              response.right);

          if (data != null) {
            emit(AdminPanelDetailsLoadedState(
              getPotHoleInformationByAdminUIdResponseModel: data,
            ));
          } else {
            emit(AdminPanelDetailsErrorState(
                errorMessage: "No Data Available!"));
          }
        } catch (e) {
          if (e is UnauthorizedException) {
            emit(NavigateToLoginPageEvent());
          } else {
            emit(AdminPanelDetailsErrorState(
                errorMessage: 'An error occurred: $e'));
          }
        }
      }
    });

    on<AdminUpdateStatusEvent>((event, emit) async {
      emit(AdminUpdateStatusLoadingState());

      final useCase = serviceLocator<AdminUpdateStatusUseCase>();
      final response = await useCase.invoke(AdminUpdateStatusRequestModel(
        assignee: assignContractorController.text,
        status: statusController.text,
        infoID: event.id,
      ));

      if (response.isLeft) {
        emit(AdminUpdateStatusErrorState(errorMessage: "Failure!"));
      } else {
        try {
          final data = response.right;

          if (data != null) {
            emit(AdminUpdateStatusLoadedState());
          } else {
            emit(AdminUpdateStatusErrorState(
                errorMessage: "No Data Available!"));
          }
        } catch (e) {
          emit(AdminUpdateStatusErrorState(
              errorMessage: 'An error occurred: $e'));
        }
      }
    });

    on<VerifyPotholeImageEvent>((event, emit) async {
      emit(AdminPanelDetailsLoadingState());
      final detailsUseCase = serviceLocator<VerifyImageUseCase>();
      final response = await detailsUseCase.invoke(VerifyPotholeImgRequestModel(
        image: event.imageUrl,
      ));

      if (response.isLeft) {
        emit(AdminPanelDetailsErrorState(errorMessage: "Failure!"));
      } else {
        try {
          final data = VerifyPotholeImgResponseModel.fromJson(response.right);

          if (data != null) {
            emit(VerifyPotholeImageLoadedState(
              verifyPotholeImgResponseModel: data,
            ));
          } else {
            emit(AdminPanelDetailsErrorState(
                errorMessage: "No Data Available!"));
          }
        } catch (e) {
          if (e is UnauthorizedException) {
            emit(NavigateToLoginPageEvent());
          } else {
            emit(AdminPanelDetailsErrorState(
                errorMessage: 'An error occurred: $e'));
          }
        }
      }
    });
  }
}
