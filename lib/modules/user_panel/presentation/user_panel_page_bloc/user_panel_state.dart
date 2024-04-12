part of 'user_panel_bloc.dart';

class UserPanelState {}

final class UserPanelInitialState extends UserPanelState {}

class UserPanelLoadingState extends UserPanelState {}

class NavigateToLoginPageEvent extends UserPanelState {}

class UserPanelLoadedState extends UserPanelState {
  final List<UserPanelResponseModel> userPanelResponse;

  UserPanelLoadedState({required this.userPanelResponse});
}

class UserPanelErrorState extends UserPanelState {
  final String errorMessage;

  UserPanelErrorState({required this.errorMessage});
}
