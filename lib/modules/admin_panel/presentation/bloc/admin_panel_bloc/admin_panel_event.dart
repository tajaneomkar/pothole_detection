part of 'admin_panel_bloc.dart';

class AdminPanelEvent {}

class FetchAdminPanelData extends AdminPanelEvent {
  final String userID;
  final String status;

  FetchAdminPanelData({required this.userID, required this.status});
}
