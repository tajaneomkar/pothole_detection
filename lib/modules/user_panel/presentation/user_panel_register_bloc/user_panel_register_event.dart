part of 'user_panel_register_bloc.dart';

sealed class UserPanelRegisterEvent extends Equatable {
  const UserPanelRegisterEvent();

  @override
  List<Object> get props => [];
}

class UserPanelRegisterInitialEvent extends UserPanelRegisterEvent {}

class UploadImageUserPanelInitialEvent extends UserPanelRegisterEvent {
  final File? file;

  const UploadImageUserPanelInitialEvent(
    this.file,
  );
}
