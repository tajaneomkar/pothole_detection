import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page_bloc/user_panel_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_detail_view.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_register_complaint.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => serviceLocator<UserPanelBloc>()
          ..add(FetchUserPanelData(
            status: "pending",
            userID: serviceLocator<SharedPreferencesService>().userID,
          )),
        child: BlocConsumer<UserPanelBloc, UserPanelState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserPanelLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserPanelLoadedState) {
              return Scaffold(
                drawer: Drawer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceLocator<SharedPreferencesService>()
                                  .userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              serviceLocator<SharedPreferencesService>()
                                  .userEmail,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                        Column(
                          children: [
                            const Divider(),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                serviceLocator<SharedPreferencesService>()
                                    .clearLoginData(context);
                              },
                              child: Container(
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(Icons.login_rounded)
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: appWhite),
                  backgroundColor: kcPrimaryColorDark,
                  centerTitle: true,
                  title: const Text('USER PANEL',
                      style: TextStyle(color: appWhite)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserPanelRegisterComplaint()),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: appWhite,
                          size: 30,
                        ))
                  ],
                  bottom: TabBar(
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 16),
                    indicatorColor: appWhite,
                    labelColor: kcOrangeColor,
                    unselectedLabelColor: appWhite,
                    onTap: (value) {
                      if (value == 0) {
                        BlocProvider.of<UserPanelBloc>(context)
                            .add(FetchUserPanelData(
                          status: "pending",
                          userID:
                              serviceLocator<SharedPreferencesService>().userID,
                        ));
                      } else if (value == 1) {
                        BlocProvider.of<UserPanelBloc>(context)
                            .add(FetchUserPanelData(
                          status: "active",
                          userID:
                              serviceLocator<SharedPreferencesService>().userID,
                        ));
                      } else {
                        BlocProvider.of<UserPanelBloc>(context)
                            .add(FetchUserPanelData(
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
                        child: state.userPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.userPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserPanelDetailView(
                                            id: state.userPanelResponse[index]
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
                                              child: Image.network(
                                                state.userPanelResponse[index]
                                                        .image ??
                                                    "",
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
                                                                    .userPanelResponse[
                                                                        index]
                                                                    .address ??
                                                                "",
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
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
                                                                    .userPanelResponse[
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
                        child: state.userPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.userPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserPanelDetailView(
                                            id: state.userPanelResponse[index]
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
                                                        .userPanelResponse[
                                                            index]
                                                        .image ??
                                                    "")),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
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
                                                                    .userPanelResponse[
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
                                                  const SizedBox(height: 10),
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
                                                                    .userPanelResponse[
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
                        child: state.userPanelResponse.isEmpty
                            ? const Center(
                                child: Text("No Records Available!!"),
                              )
                            : ListView.separated(
                                itemCount: state.userPanelResponse.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserPanelDetailView(
                                            id: state.userPanelResponse[index]
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
                                                        .userPanelResponse[
                                                            index]
                                                        .image ??
                                                    "")),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
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
                                                                    .userPanelResponse[
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
                                                  const SizedBox(height: 10),
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
                                                                    .userPanelResponse[
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
            } else if (state is UserPanelErrorState) {
              serviceLocator<SharedPreferencesService>()
                  .clearLoginData(context);
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
        ),
      ),
    );
  }
}
