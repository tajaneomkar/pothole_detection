import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/config/router/app_router.dart';
import 'package:pothole_detection/config/router/app_router.gr.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page_bloc/user_panel_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

@RoutePage()
class UserPanelPage extends StatefulWidget {
  const UserPanelPage({super.key});

  @override
  State<UserPanelPage> createState() => UserPanelPageState();
}

class UserPanelPageState extends State<UserPanelPage> {
  final String status = "pending";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: appWhite),
        backgroundColor: kcPrimaryColorDark,
        centerTitle: true,
        title: const Text('USER PANEL', style: TextStyle(color: appWhite)),
        actions: [
          IconButton(
              onPressed: () {
                serviceLocator<AppRouter>()
                    .push(const UserPanelRegisterComplaint());
              },
              icon: const Icon(
                Icons.add,
                color: appWhite,
                size: 30,
              ))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 16),
                indicatorColor: appTextColor,
                labelColor: kcOrangeColor,
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BlocProvider(
                      create: (context) => UserPanelBloc()
                        ..add(FetchUserPanelData(
                            userID: serviceLocator<SharedPreferencesService>()
                                .userID,
                            status: "pending")),
                      child: BlocBuilder<UserPanelBloc, UserPanelState>(
                        builder: (context, state) {
                          if (state is UserPanelLoadedState) {
                            return state.userPanelResponse.isNotEmpty
                                ? ListView.separated(
                                    itemCount: state.userPanelResponse.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          serviceLocator<AppRouter>().push(
                                            UserPanelDetailView(
                                              id: state.userPanelResponse[index]
                                                      .id ??
                                                  "",
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
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
                                                                    fontSize:
                                                                        15,
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
                                  )
                                : const Center(child: Text("No Data Found"));
                          } else if (state is UserPanelLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(child: Text("No Data Found"));
                          }
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => UserPanelBloc()
                        ..add(FetchUserPanelData(
                            userID: serviceLocator<SharedPreferencesService>()
                                .userID,
                            status: "active")),
                      child: BlocBuilder<UserPanelBloc, UserPanelState>(
                        builder: (context, state) {
                          if (state is UserPanelLoadedState) {
                            return state.userPanelResponse.isNotEmpty
                                ? ListView.separated(
                                    itemCount: state.userPanelResponse.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          serviceLocator<AppRouter>().push(
                                            UserPanelDetailView(
                                              id: state.userPanelResponse[index]
                                                      .id ??
                                                  "",
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
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
                                                                    fontSize:
                                                                        15,
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
                                  )
                                : const Center(child: Text("No Data Found"));
                          } else if (state is UserPanelLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(child: Text("No Data Found"));
                          }
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => UserPanelBloc()
                        ..add(FetchUserPanelData(
                            userID: serviceLocator<SharedPreferencesService>()
                                .userID,
                            status: "completed")),
                      child: BlocBuilder<UserPanelBloc, UserPanelState>(
                        builder: (context, state) {
                          if (state is UserPanelLoadedState) {
                            return state.userPanelResponse.isNotEmpty
                                ? ListView.separated(
                                    itemCount: state.userPanelResponse.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          serviceLocator<AppRouter>().push(
                                            UserPanelDetailView(
                                              id: state.userPanelResponse[index]
                                                      .id ??
                                                  "",
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
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
                                                                    fontSize:
                                                                        15,
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
                                  )
                                : const Center(child: Text("No Data Found"));
                          } else if (state is UserPanelLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(child: Text("No Data Found"));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceLocator<SharedPreferencesService>().userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  serviceLocator<SharedPreferencesService>().userEmail,
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
                    serviceLocator<SharedPreferencesService>().clearLoginData();
                    serviceLocator<AppRouter>().replace(const LoginRoute());
                  },
                  child: Container(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
