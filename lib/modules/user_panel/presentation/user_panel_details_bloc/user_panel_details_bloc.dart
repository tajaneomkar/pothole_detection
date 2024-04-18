import 'package:bloc/bloc.dart';
import 'package:pothole_detection/modules/user_panel/data/model/get_pot_hole_by_uid_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/get_pot_hole_by_uid_response_model.dart';
import 'package:pothole_detection/modules/user_panel/domain/usecases/user_panel_usecases.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/network/custom_exception.dart';
part 'user_panel_details_event.dart';
part 'user_panel_details_state.dart';

class UserPanelDetailsBloc
    extends Bloc<UserPanelDetailsEvent, UserPanelDetailsState> {
  UserPanelDetailsBloc() : super(UserPanelDetailsInitial()) {
    on<UserPanelDetailsEvent>((event, emit) {});

    on<UserPanelDetailsInitialEvent>(
      (event, emit) async {
        emit(UserPanelDetailsLoadingState());
        final detailsUseCase = serviceLocator<GetPotHoleByUIdUseCase>();
        final response =
            await detailsUseCase.invoke(GetPotHoleInformationByUIdRequestModel(
          infoID: event.id,
        ));

        if (response.isLeft) {
          emit(UserPanelDetailsErrorState(errorMessage: "Failure!"));
        } else {
          try {
            final data = GetPotHoleInformationByUIdResponseModel.fromJson(
                response.right);

            if (data != null) {
              emit(UserPanelDetailsLoadedState(
                getPotHoleInformationByUIdResponseModel: data,
              ));
            } else {
              emit(UserPanelDetailsErrorState(
                  errorMessage: "No Data Available!"));
            }
          } catch (e) {
            if (e is UnauthorizedException) {
              emit(NavigateToLoginPageEvent());
            } else {
              emit(UserPanelDetailsErrorState(
                  errorMessage: 'An error occurred: $e'));
            }
          }
        }
      },
    );
  }
}
