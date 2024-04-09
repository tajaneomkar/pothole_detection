part of 'user_panel_bloc.dart';

abstract class UserPanelEvent {}

class FetchUserPanelData extends UserPanelEvent {
  final String userID;
  final String status;

  FetchUserPanelData({required this.userID, required this.status});
}
