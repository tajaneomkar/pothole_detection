part of 'user_panel_register_bloc.dart';

sealed class UserPanelRegisterState extends Equatable {
  const UserPanelRegisterState();

  @override
  List<Object> get props => [];
}

final class UserPanelRegisterInitial extends UserPanelRegisterState {}

final class UserPanelRegisterLoading extends UserPanelRegisterState {}

final class UserPanelRegisterLoaded extends UserPanelRegisterState {}

final class UserPanelRegisterError extends UserPanelRegisterState {
  final String errorMessage;
  const UserPanelRegisterError({required this.errorMessage});
}

final class UploadImageUserPanelLoading extends UserPanelRegisterState {}

final class UploadImageUserPanelSuccess extends UserPanelRegisterState {}

final class UploadImageUserPanelError extends UserPanelRegisterState {
  final String errorMessage;
  UploadImageUserPanelError({
    required this.errorMessage,
  });
}
