import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_detail_view.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/bloc/admin_panel_bloc/admin_panel_bloc.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => serviceLocator<AdminPanelBloc>()
          ..add(FetchAdminPanelData(
            status: "pending",
            userID: serviceLocator<SharedPreferencesService>().userID,
          )),
        child: BlocConsumer<AdminPanelBloc, AdminPanelState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AdminPanelLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NavigateToLoginPageEvent) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            } else if (state is AdminPanelLoadedState) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: kcPrimaryColorDark,
                  centerTitle: true,
                  title: const Text('Admin PANEL',
                      style: TextStyle(color: appWhite)),
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 16),
                    indicatorColor: appWhite,
                    labelColor: kcOrangeColor,
                    unselectedLabelColor: appWhite,
                    onTap: (value) {
                      if (value == 0) {
                        BlocProvider.of<AdminPanelBloc>(context)
                            .add(FetchAdminPanelData(
                          status: "pending",
                          userID:
                              serviceLocator<SharedPreferencesService>().userID,
                        ));
                      } else if (value == 1) {
                        BlocProvider.of<AdminPanelBloc>(context)
                            .add(FetchAdminPanelData(
                          status: "active",
                          userID:
                              serviceLocator<SharedPreferencesService>().userID,
                        ));
                      } else {
                        BlocProvider.of<AdminPanelBloc>(context)
                            .add(FetchAdminPanelData(
                          status: "completed",
                          userID:
                              serviceLocator<SharedPreferencesService>().userID,
                        ));
                      }
                    },
                    tabs: const [
                      Tab(text: 'Pending'),
                      Tab(text: 'Active'),
                      Tab(text: 'Completed'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Column(children: [
                      Expanded(
                        child: state.adminPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.adminPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdminPanelDetailView(
                                            id: state.adminPanelResponse[index]
                                                    .id ??
                                                "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              height: 60,
                                              width: 60,
                                              child: Image.memory(
                                                base64Decode(state
                                                        .adminPanelResponse[
                                                            index]
                                                        .image ??
                                                    ""),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    state
                                                            .adminPanelResponse[
                                                                index]
                                                            .name ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Flexible(
                                                        child: Text(
                                                          'Location: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .address ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Date of Register: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .date ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ]),
                    Column(children: [
                      Expanded(
                        child: state.adminPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.adminPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdminPanelDetailView(
                                            id: state.adminPanelResponse[index]
                                                    .id ??
                                                "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                height: 60,
                                                width: 60,
                                                child: Image.network(state
                                                        .adminPanelResponse[
                                                            index]
                                                        .image ??
                                                    "")
                                                // Image.network(state
                                                //         .adminPanelResponse[
                                                //             index]
                                                //         .image ??
                                                //     "")
                                                // Image.memory(
                                                //   base64Decode(state
                                                //           .adminPanelResponse[
                                                //               index]
                                                //           .image ??
                                                //       ""),
                                                //   fit: BoxFit.fill,
                                                // ),
                                                ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    state
                                                            .adminPanelResponse[
                                                                index]
                                                            .name ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Flexible(
                                                        child: Text(
                                                          'Location: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .address ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Date of Register: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .date ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ]),
                    Column(children: [
                      Expanded(
                        child: state.adminPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.adminPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdminPanelDetailView(
                                            id: state.adminPanelResponse[index]
                                                    .id ??
                                                "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                height: 60,
                                                width: 60,
                                                child: Image.network(state
                                                        .adminPanelResponse[
                                                            index]
                                                        .image ??
                                                    "")
                                                //  Image.memory(
                                                //   base64Decode(state
                                                //           .adminPanelResponse[
                                                //               index]
                                                //           .image ??
                                                //       ""),
                                                //   fit: BoxFit.fill,
                                                // ),
                                                ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    state
                                                            .adminPanelResponse[
                                                                index]
                                                            .name ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Flexible(
                                                        child: Text(
                                                          'Location: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .address ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Date of Register: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text(
                                                            state
                                                                    .adminPanelResponse[
                                                                        index]
                                                                    .date ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ]),
                  ],
                ),
              );
            } else if (state is AdminPanelErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
