part of 'admin_panel_bloc.dart';

class AdminPanelState {}

class AdminPanelInitialState extends AdminPanelState {}

class AdminPanelLoadingState extends AdminPanelState {}

class NavigateToLoginPageEvent extends AdminPanelState {}

class AdminPanelLoadedState extends AdminPanelState {
  final List<AdminPanelResponseModel> adminPanelResponse;

  AdminPanelLoadedState({required this.adminPanelResponse});
}

class AdminPanelErrorState extends AdminPanelState {
  final String errorMessage;

  AdminPanelErrorState({required this.errorMessage});
}
