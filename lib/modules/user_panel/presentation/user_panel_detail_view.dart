import 'package:flutter/material.dart';

class UserPanelDetailView extends StatefulWidget {
  const UserPanelDetailView({super.key});

  @override
  State<UserPanelDetailView> createState() => _UserPanelDetailViewState();
}

class _UserPanelDetailViewState extends State<UserPanelDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 25, left: 12, right: 12),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                    fit: BoxFit.fill,
                    'https://media.istockphoto.com/id/929942316/photo/old-highway-with-holes-and-snow-landscape-road-potholes-in-cloudy-winter-weather-concept.jpg?s=612x612&w=0&k=20&c=ZtK8wJgXLQYEWGMJVGeyZBqVPKsdHMQlml1Vx8i17aw='),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Robert Downey',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email-Id: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Flexible(
                    child: Text('abcd@gmail.com',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Flexible(
                    child: Text('9874516546',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text('Date: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Text('12/02/2023',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Flexible(
                    child: Text(
                        'Pothole detection is a technology-driven process aimed at identifying and monitoring potholes on roads, typically using sensors, cameras, or other imaging devices mounted on vehicles or stationary infrastructure. The detection process involves capturing data such as images or vibrations from the road surface and analyzing it to identify irregularities indicative of potholes.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Flexible(
                    child: Text(
                        'Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
