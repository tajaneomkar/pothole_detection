part of 'user_panel_details_bloc.dart';

sealed class UserPanelDetailsState extends Equatable {
  const UserPanelDetailsState();

  @override
  List<Object> get props => [];
}

final class UserPanelDetailsInitial extends UserPanelDetailsState {}

class UserPanelDetailsLoadingState extends UserPanelDetailsState {}

class UserPanelDetailsLoadedState extends UserPanelDetailsState {
  final GetPotHoleInformationByUIdResponseModel
      getPotHoleInformationByUIdResponseModel;

  const UserPanelDetailsLoadedState(
      {required this.getPotHoleInformationByUIdResponseModel});
}

class UserPanelDetailsErrorState extends UserPanelDetailsState {
  final String errorMessage;

  const UserPanelDetailsErrorState({required this.errorMessage});
}
