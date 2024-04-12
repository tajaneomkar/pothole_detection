import 'package:bloc/bloc.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_panel_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_panel_response_model.dart';
import 'package:pothole_detection/modules/admin_panel/domain/usecases/admin_panel_usecases.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/network/custom_exception.dart';
part 'admin_panel_event.dart';
part 'admin_panel_state.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  AdminPanelBloc() : super(AdminPanelInitialState()) {
    on<FetchAdminPanelData>((event, emit) async {
      emit(AdminPanelLoadingState());

      try {
        final adminPanelUseCase = serviceLocator<AdminPanelUseCase>();
        final response = await adminPanelUseCase.invoke(AdminPanelRequestModel(
          status: event.status,
          userID: event.userID,
        ));

        if (response.isLeft) {
          emit(AdminPanelErrorState(errorMessage: "Failure!"));
        } else {
          try {
            final res = response.right as List<dynamic>;
            List<AdminPanelResponseModel> data = [];
            res
                .map(
                  (e) => data.add(AdminPanelResponseModel.fromJson(e)),
                )
                .toList();

            if (data != []) {
              emit(AdminPanelLoadedState(
                adminPanelResponse: data,
              ));
            } else {
              emit(AdminPanelErrorState(errorMessage: "No Data Available!"));
            }
          } catch (e) {
            if (e is UnauthorizedException) {
              emit(NavigateToLoginPageEvent());
            } else {
              emit(AdminPanelErrorState(errorMessage: 'An error occurred: $e'));
            }
          }
        }
      } catch (e) {
        if (e is UnauthorizedException) {
          emit(NavigateToLoginPageEvent());
        } else {
          emit(AdminPanelErrorState(errorMessage: 'An error occurred: $e'));
        }
      }
    });
  }
}
