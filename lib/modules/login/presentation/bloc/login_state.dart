part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponseModel? response;
  LoginSuccessState({this.response});
}

class LoginFailureState extends LoginState {
  String? errorMessage;
  LoginFailureState({this.errorMessage});
}

class LoginEmptyState extends LoginState {}
