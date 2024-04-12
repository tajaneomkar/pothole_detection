part of 'user_panel_details_bloc.dart';

class UserPanelDetailsState {}

final class UserPanelDetailsInitial extends UserPanelDetailsState {}

class UserPanelDetailsLoadingState extends UserPanelDetailsState {}

class UserPanelDetailsLoadedState extends UserPanelDetailsState {
  final GetPotHoleInformationByUIdResponseModel
      getPotHoleInformationByUIdResponseModel;

  UserPanelDetailsLoadedState(
      {required this.getPotHoleInformationByUIdResponseModel});
}

class UserPanelDetailsErrorState extends UserPanelDetailsState {
  final String errorMessage;

  UserPanelDetailsErrorState({required this.errorMessage});
}

class NavigateToLoginPageEvent extends UserPanelDetailsState {}
