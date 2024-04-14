import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_details_bloc/user_panel_details_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';

class UserPanelDetailView extends StatefulWidget {
  const UserPanelDetailView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<UserPanelDetailView> createState() => _UserPanelDetailViewState();
}

class _UserPanelDetailViewState extends State<UserPanelDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserPanelDetailsBloc, UserPanelDetailsState>(
      bloc: serviceLocator<UserPanelDetailsBloc>()
        ..add(
          UserPanelDetailsInitialEvent(
            id: widget.id,
          ),
        ),
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserPanelDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserPanelDetailsLoadedState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'COMPLAINT DETAILS',
                style: TextStyle(color: appWhite),
              ),
              iconTheme: const IconThemeData(color: appWhite),
              backgroundColor: kcPrimaryColorDark,
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 25, left: 12, right: 12),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              width: double.infinity,
                              height: 250,
                              state.getPotHoleInformationByUIdResponseModel
                                      .image ??
                                  '',
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state
                                .getPotHoleInformationByUIdResponseModel.name ??
                            '',
                        label: 'Name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state.getPotHoleInformationByUIdResponseModel
                                .email ??
                            '',
                        label: 'Email-Id',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state.getPotHoleInformationByUIdResponseModel
                                .phoneNo ??
                            '',
                        label: 'Contact',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state
                                .getPotHoleInformationByUIdResponseModel.date ??
                            '',
                        label: 'Date',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state.getPotHoleInformationByUIdResponseModel
                                .description ??
                            '',
                        label: 'Description',
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        enabled: false,
                        hint: state.getPotHoleInformationByUIdResponseModel
                                .address ??
                            '',
                        label: 'Address',
                        maxLines: 6,
                      ),
                    ]),
              ),
            ),
          );
        } else if (state is UserPanelDetailsErrorState) {
          serviceLocator<SharedPreferencesService>().clearLoginData(context);
          return Center(
            child: Text(
              state.errorMessage,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
