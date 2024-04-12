import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_page.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/bloc/admin_detail_view_bloc/admin_detail_view_bloc.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
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
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kcPrimaryColorDark,
                  iconTheme: const IconThemeData(color: appWhite),
                  title: const Text('COMPLAIANT DETAILS',
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              state.getPotHoleInformationByAdminUIdResponseModel
                                      .image ??
                                  '',
                              fit: BoxFit.fill,
                            ),
                          ),
                          if (state.getPotHoleInformationByAdminUIdResponseModel
                                  .status
                                  ?.toLowerCase() ==
                              'pending') ...[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        BlocProvider.of<AdminDetailViewBloc>(
                                                context)
                                            .add(VerifyPotholeImageEvent(
                                                imageUrl: state
                                                        .getPotHoleInformationByAdminUIdResponseModel
                                                        .image ??
                                                    ''));
                                      },
                                      child: const Text(
                                        'Verify the Pothole Image',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: kcPrimaryColorDark),
                                      ))
                                ]),
                          ],
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              state.getPotHoleInformationByAdminUIdResponseModel
                                      .name ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Email-Id: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Flexible(
                                child: Text(
                                    state.getPotHoleInformationByAdminUIdResponseModel
                                            .email ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contact: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Flexible(
                                child: Text(
                                    state.getPotHoleInformationByAdminUIdResponseModel
                                            .phoneNo ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text('Date: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Text(
                                  state.getPotHoleInformationByAdminUIdResponseModel
                                          .date ??
                                      '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Description: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Flexible(
                                child: Text(
                                    state.getPotHoleInformationByAdminUIdResponseModel
                                            .description ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Address: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Flexible(
                                child: Text(
                                    state.getPotHoleInformationByAdminUIdResponseModel
                                            .address ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
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
                                  .text = value ?? "";
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
                            initialValue: state
                                    .getPotHoleInformationByAdminUIdResponseModel
                                    .assignee ??
                                '',
                            onChanged: (value) {
                              BlocProvider.of<AdminDetailViewBloc>(context)
                                  .assignContractorController
                                  .text = value ?? "";
                            },
                            items: const [
                              'Sayali',
                              'Anushri',
                              'Dhiraj',
                              'Priyanka'
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
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   const SnackBar(
                                      //     backgroundColor: kcPrimaryColor,
                                      //     duration: Duration(seconds: 1),
                                      //     content: Text(
                                      //         'Client Complaint Updated Successfully'),
                                      //   ),
                                      // );
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
            return Center(
              child: Text(
                state.errorMessage,
              ),
            );
          } else if (state is NavigateToLoginPageEvent) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {
          if (state is AdminPanelDetailsErrorState) {
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
