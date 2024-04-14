import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_page.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/bloc/admin_detail_view_bloc/admin_detail_view_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/widget/popup_dailog.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';
import 'package:pothole_detection/utils/common/custom_search_dropdown.dart';

class AdminPanelDetailView extends StatefulWidget {
  const AdminPanelDetailView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<AdminPanelDetailView> createState() => _AdminPanelDetailViewState();
}

class _AdminPanelDetailViewState extends State<AdminPanelDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDetailViewBloc(),
      child: BlocConsumer<AdminDetailViewBloc, AdminDetailViewState>(
        bloc: serviceLocator<AdminDetailViewBloc>()
          ..add(
            AdminPanelDetailsInitialEvent(
              id: widget.id,
            ),
          ),
        builder: (context, state) {
          if (state is AdminPanelDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdminPanelDetailsLoadedState) {
            String? imageUrl =
                state.getPotHoleInformationByAdminUIdResponseModel.image ?? '';
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kcPrimaryColorDark,
                  iconTheme: const IconThemeData(color: appWhite),
                  title: const Text('COMPLAINT DETAILS',
                      style: TextStyle(color: appWhite, fontSize: 18)),
                  centerTitle: true,
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
                                state.getPotHoleInformationByAdminUIdResponseModel
                                        .image ??
                                    '',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          if (state.getPotHoleInformationByAdminUIdResponseModel
                                  .status
                                  ?.toLowerCase() ==
                              'pending') ...[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocConsumer<AdminDetailViewBloc,
                                      AdminDetailViewState>(
                                    listener: (context, state) {
                                      if (state
                                          is AdminPanelDetailsLoadingState) {
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state
                                          is VerifyPotholeImageLoadedState) {
                                        if (state.verifyPotholeImgResponseModel
                                                .response ==
                                            'notpothole\n') {
                                          IconMessagePopup.show(
                                            circleColor: dashboardContainer2,
                                            context,
                                            iconData:
                                                Icons.info_outline_rounded,
                                            message:
                                                'This is not Pothole Image',
                                            iconColor: Colors.red,
                                            iconSize: 64.0,
                                            onPressed: () {
                                              Navigator.canPop(context);
                                            },
                                          );
                                        } else {
                                          IconMessagePopup.show(
                                            circleColor: dashboardContainer2,
                                            context,
                                            iconData: Icons.check,
                                            message: 'This is Pothole Image',
                                            iconColor: Colors.green,
                                            iconSize: 64.0,
                                            onPressed: () {
                                              Navigator.canPop(context);
                                            },
                                          );
                                        }
                                      }
                                    },
                                    builder: (context, state) {
                                      return TextButton(
                                          onPressed: () {
                                            BlocProvider.of<
                                                        AdminDetailViewBloc>(
                                                    context)
                                                .add(VerifyPotholeImageEvent(
                                                    imageUrl: imageUrl));
                                          },
                                          child: const Text(
                                            'Verify the Pothole Image',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: kcPrimaryColorDark),
                                          ));
                                    },
                                  ),
                                ]),
                          ],
                          const SizedBox(
                            height: 5,
                          ),
                          AppInputField(
                            enabled: false,
                            hint: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .name ??
                                '',
                            label: 'Name',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppInputField(
                            enabled: false,
                            hint: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .email ??
                                '',
                            label: 'Email-Id',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppInputField(
                            enabled: false,
                            hint: state
                                    .getPotHoleInformationByAdminUIdResponseModel
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
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .date ??
                                '',
                            label: 'Date',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppInputField(
                            maxLines: 6,
                            enabled: false,
                            hint: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .description ??
                                '',
                            label: 'Description',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppInputField(
                            maxLines: 6,
                            enabled: false,
                            hint: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .address ??
                                '',
                            label: 'Address',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Status: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomSearchDropdown(
                            initialValue: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .status ??
                                '',
                            onChanged: (value) {
                              BlocProvider.of<AdminDetailViewBloc>(context)
                                  .statusController
                                  .text = value ?? '';
                            },
                            onSaved: (value) {
                              BlocProvider.of<AdminDetailViewBloc>(context)
                                  .statusController
                                  .text = value ?? '';
                            },
                            items: const ['active', 'pending', 'completed'],
                            showSearchBox: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Assign Contractor: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomSearchDropdown(
                            isEnable:
                                state.getPotHoleInformationByAdminUIdResponseModel
                                            .status ==
                                        'pending'
                                    ? true
                                    : false,
                            initialValue: state
                                        .getPotHoleInformationByAdminUIdResponseModel
                                        .status ==
                                    'pending'
                                ? " "
                                : state.getPotHoleInformationByAdminUIdResponseModel
                                        .assignee ??
                                    '',
                            onChanged: (value) {
                              BlocProvider.of<AdminDetailViewBloc>(context)
                                  .assignContractorController
                                  .text = value ?? '';
                            },
                            items: const [
                              'Sayali Shardul',
                              'Asmita Shimpi',
                              'Anushri Sonwane ',
                              'Purva Kohok '
                            ],
                            showSearchBox: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocProvider.value(
                            value:
                                BlocProvider.of<AdminDetailViewBloc>(context),
                            child: BlocConsumer<AdminDetailViewBloc,
                                AdminDetailViewState>(
                              listener: (context, state) {
                                if (state is AdminUpdateStatusLoadedState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: kcPrimaryColor,
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'Client Complaint Updated Successfully'),
                                    ),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const AdminPanel(),
                                    ),
                                  );
                                } else if (state is NavigateToLoginPageEvent) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomButton(
                                    textColor: appWhite,
                                    isLoading:
                                        state is AdminUpdateStatusLoadingState
                                            ? true
                                            : false,
                                    buttonColor: kcPrimaryColorDark,
                                    height: 45,
                                    onPressed: () {
                                      BlocProvider.of<AdminDetailViewBloc>(
                                              context)
                                          .add(AdminUpdateStatusEvent(
                                              id: widget.id));
                                    },
                                    text: 'Submit');
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ));
          } else if (state is AdminPanelDetailsErrorState) {
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
        listener: (context, state) {
          if (state is AdminPanelDetailsErrorState) {
            serviceLocator<SharedPreferencesService>().clearLoginData(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
