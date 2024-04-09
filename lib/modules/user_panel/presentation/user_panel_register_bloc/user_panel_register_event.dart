part of 'user_panel_register_bloc.dart';

sealed class UserPanelRegisterEvent extends Equatable {
  const UserPanelRegisterEvent();

  @override
  List<Object> get props => [];
}

class UserPanelRegisterInitialEvent extends UserPanelRegisterEvent {}

class UploadImageUserPanelInitialEvent extends UserPanelRegisterEvent {
  final Uint8List? bytes;

  const UploadImageUserPanelInitialEvent(this.bytes);
}
