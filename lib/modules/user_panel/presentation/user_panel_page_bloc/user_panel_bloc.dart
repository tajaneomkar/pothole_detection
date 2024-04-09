import 'package:bloc/bloc.dart';
import 'package:pothole_detection/modules/user_panel/data/model/user_panel_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/user_panel_response_model.dart';
import 'package:pothole_detection/modules/user_panel/domain/usecases/user_panel_usecases.dart';
import 'package:pothole_detection/services/service_locator.dart';
part 'user_panel_event.dart';
part 'user_panel_state.dart';

class UserPanelBloc extends Bloc<UserPanelEvent, UserPanelState> {
  UserPanelBloc() : super(UserPanelInitialState()) {
    on<FetchUserPanelData>(
      (event, emit) async {
        emit(UserPanelLoadingState());

        try {
          final userPanelUseCase = serviceLocator<UserPanelUseCase>();
          final response = await userPanelUseCase.invoke(UserPanelRequestModel(
            status: event.status,
            userID: event.userID,
          ));

          if (response.isLeft) {
            emit(UserPanelErrorState(errorMessage: "Failure!"));
          } else {
            try {
              final res = response.right as List<dynamic>;
              List<UserPanelResponseModel> data = [];
              res
                  .map(
                    (e) => data.add(UserPanelResponseModel.fromJson(e)),
                  )
                  .toList();

              if (data != []) {
                emit(UserPanelLoadedState(
                  userPanelResponse: data,
                ));
              } else {
                emit(UserPanelErrorState(errorMessage: "No Data Available!"));
              }
            } catch (e) {
              emit(UserPanelErrorState(errorMessage: 'An error occurred: $e'));
            }
          }
        } catch (e) {
          emit(UserPanelErrorState(errorMessage: 'An error occurred: $e'));
        }
      },
    );
  }
}
