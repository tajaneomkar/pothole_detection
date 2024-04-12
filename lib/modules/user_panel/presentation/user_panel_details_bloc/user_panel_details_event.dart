part of 'user_panel_details_bloc.dart';

class UserPanelDetailsEvent {}

class UserPanelDetailsInitialEvent extends UserPanelDetailsEvent {
  final String id;

  UserPanelDetailsInitialEvent({
    required this.id,
  });
}
