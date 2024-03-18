import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_detail_view.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_register_complaint.dart';
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColorDark,
          centerTitle: true,
          title: const Text('USER PANEL', style: TextStyle(color: appWhite)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
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
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 16),
            indicatorColor: appWhite,
            labelColor: kcOrangeColor,
            unselectedLabelColor: appWhite,
            tabs: [
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
                child: ListView.separated(
                  itemCount: 25,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserPanelDetailView()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Location: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text('Nashik',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Date of Register: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text('16/08/2023',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
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
                child: ListView.separated(
                  itemCount: 25,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserPanelDetailView()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Location: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text('Nashik',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Date of Register: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text('16/08/2023',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
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
                child: ListView.separated(
                  itemCount: 25,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserPanelDetailView()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Location: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text('Nashik',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Date of Register: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text('16/08/2023',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
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
      ),
    );
  }
}
