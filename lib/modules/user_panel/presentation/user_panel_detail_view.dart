import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_details_bloc/user_panel_details_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';

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
            appBar: AppBar(),
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
                            child: Image.memory(
                              width: double.infinity,
                              height: 250,
                              base64Decode(state
                                      .getPotHoleInformationByUIdResponseModel
                                      .image ??
                                  ''),
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                            state.getPotHoleInformationByUIdResponseModel
                                    .name ??
                                '',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email-Id: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                                state.getPotHoleInformationByUIdResponseModel
                                        .email ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                                state.getPotHoleInformationByUIdResponseModel
                                        .phoneNo ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 5),
                          Text(
                              state.getPotHoleInformationByUIdResponseModel
                                      .date ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
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
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                                state.getPotHoleInformationByUIdResponseModel
                                        .description ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                                state.getPotHoleInformationByUIdResponseModel
                                        .address ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          );
        } else if (state is UserPanelDetailsErrorState) {
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
    );
  }
}
