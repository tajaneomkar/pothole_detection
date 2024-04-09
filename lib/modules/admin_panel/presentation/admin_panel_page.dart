import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_detail_view.dart';
import 'package:pothole_detection/modules/admin_panel/widget/admin_panel_list_Item_widget.dart';
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
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 247, 244, 244),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kcPrimaryColorDark,
            title: const Text(
              'ADMIN PANEL',
              style: TextStyle(color: appWhite),
            ),
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
              AdminPanelListItem(
                  itrmCount: 8,
                  name: 'Robert Saert',
                  location: 'Nashik',
                  dateOfRegister: '16/08/2023',
                  imageUrl:
                      'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AdminPanelDetailView(),
                      ),
                    );
                  }),
              AdminPanelListItem(
                  itrmCount: 6,
                  name: 'Asiyan Kart',
                  location: 'Pune',
                  dateOfRegister: '25/03/2023',
                  imageUrl:
                      'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AdminPanelDetailView(),
                      ),
                    );
                  }),
              AdminPanelListItem(
                  itrmCount: 2,
                  name: 'Paul Dinda',
                  location: 'Mumbai',
                  dateOfRegister: '01/12/2023',
                  imageUrl:
                      'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw=',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AdminPanelDetailView(),
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
