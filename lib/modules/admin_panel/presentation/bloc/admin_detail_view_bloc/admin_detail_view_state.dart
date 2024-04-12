part of 'admin_detail_view_bloc.dart';

class AdminDetailViewState {}

final class AdminDetailViewInitial extends AdminDetailViewState {}

class AdminPanelDetailsLoadingState extends AdminDetailViewState {}

class AdminUpdateStatusLoadingState extends AdminDetailViewState {}

class AdminPanelDetailsLoadedState extends AdminDetailViewState {
  final GetPotHoleInformationByAdminUIdResponseModel
      getPotHoleInformationByAdminUIdResponseModel;

  AdminPanelDetailsLoadedState(
      {required this.getPotHoleInformationByAdminUIdResponseModel});
}

class VerifyPotholeImageLoadedState extends AdminDetailViewState {
  final VerifyPotholeImgResponseModel verifyPotholeImgResponseModel;

  VerifyPotholeImageLoadedState({required this.verifyPotholeImgResponseModel});
}

class AdminUpdateStatusLoadedState extends AdminDetailViewState {}

class AdminPanelDetailsErrorState extends AdminDetailViewState {
  final String errorMessage;

  AdminPanelDetailsErrorState({required this.errorMessage});
}

class AdminUpdateStatusErrorState extends AdminDetailViewState {
  final String errorMessage;

  AdminUpdateStatusErrorState({required this.errorMessage});
}

class NavigateToLoginPageEvent extends AdminDetailViewState {}
