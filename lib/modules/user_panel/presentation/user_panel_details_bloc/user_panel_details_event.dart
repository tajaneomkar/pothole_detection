part of 'user_panel_details_bloc.dart';

sealed class UserPanelDetailsEvent extends Equatable {
  const UserPanelDetailsEvent();

  @override
  List<Object> get props => [];
}

class UserPanelDetailsInitialEvent extends UserPanelDetailsEvent {
  final String id;

  const UserPanelDetailsInitialEvent({
    required this.id,
  });
}
