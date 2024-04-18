import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/login/data/model/login_request_model.dart';
import 'package:pothole_detection/modules/login/data/model/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {});
    on<CheckLoginData>(
      (event, emit) => checkSavedLoginData(emit),
    );
    on<LoginInitialEvent>(loginInitialEvent);
  }

  Future<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      LoginRequestModel body =
          LoginRequestModel(userName: event.userName, password: event.password);
      var headers = <String, String>{};
      headers["Content-Type"] = "application/json";

      final response = await http.post(
        Uri.parse(
            "https://soham0708-pothole-detect.hf.space/api/user/userLogin"),
        headers: headers,
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final accessToken = responseData['access_token'];
        final userData = responseData['user_data'];

        serviceLocator<SharedPreferencesService>().authToken = accessToken;
        serviceLocator<SharedPreferencesService>().userID = userData["id"];
        serviceLocator<SharedPreferencesService>().userRole = userData["role"];
        serviceLocator<SharedPreferencesService>().userEmail =
            userData["email"];
        serviceLocator<SharedPreferencesService>().userName =
            userData["username"];
        serviceLocator<SharedPreferencesService>().isLogged = true;

        final LoginResponseModel loginResponse =
            LoginResponseModel.fromJson(responseData);
        emit(LoginSuccessState(response: loginResponse));
      } else {
        emit(LoginFailureState(errorMessage: 'Failed to login'));
      }
    } catch (e) {
      emit(LoginFailureState(errorMessage: 'An error occurred: $e'));
    }
  }

  Future<void> saveLoginData(
      String accessToken, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
    prefs.setString('user_data', json.encode(userData));
  }

  Future<void> checkSavedLoginData(Emitter<LoginState> emit) async {
    final accessToken = serviceLocator<SharedPreferencesService>().authToken;
    final userId = serviceLocator<SharedPreferencesService>().userID;
    final userRole = serviceLocator<SharedPreferencesService>().userRole;
    final userEmail = serviceLocator<SharedPreferencesService>().userEmail;
    final userName = serviceLocator<SharedPreferencesService>().userName;

    if (accessToken != "" &&
        userId != "" &&
        userRole != "" &&
        userName != "" &&
        userEmail != "") {
      final loginResponse = LoginResponseModel(
        accessToken: accessToken,
        userData: UserData(
            email: userEmail, id: userId, username: userName, role: userRole),
      );
      emit(LoginSuccessState(response: loginResponse));
    }
  }
}
