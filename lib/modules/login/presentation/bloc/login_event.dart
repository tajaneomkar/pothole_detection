part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {
  final String? userName;
  final String? password;

  LoginInitialEvent({this.userName, this.password});
}

class CheckLoginData extends LoginEvent {}
