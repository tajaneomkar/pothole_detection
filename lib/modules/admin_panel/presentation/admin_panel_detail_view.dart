import 'package:flutter/material.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';
import 'package:pothole_detection/utils/common/custom_search_dropdown.dart';

class AdminPanelDetailView extends StatefulWidget {
  const AdminPanelDetailView({super.key});

  @override
  State<AdminPanelDetailView> createState() => _AdminPanelDetailViewState();
}

class _AdminPanelDetailViewState extends State<AdminPanelDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColorDark,
          iconTheme: const IconThemeData(color: appWhite),
          title: const Text('COMPLAIANT DETAILS',
              style: TextStyle(color: appWhite, fontSize: 18)),
          centerTitle: true,
        ),
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Verify the Pothole Image',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: kcPrimaryColorDark),
                    ))
              ]),
              const SizedBox(
                height: 5,
              ),
              const Text('Robert Downey',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 10,
              ),
              const Text('Status: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 5,
              ),
              const CustomSearchDropdown(
                items: ['Active', 'Pending', 'Complete'],
                showSearchBox: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Assign Contractor: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 5,
              ),
              const CustomSearchDropdown(
                items: ['abcd', 'efgh', 'ijkl'],
                showSearchBox: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  textColor: appWhite,
                  isLoading: true,
                  buttonColor: kcPrimaryColorDark,
                  height: 45,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: kcPrimaryColor,
                        duration: Duration(seconds: 1),
                        content: Text('Your Complaint Assigned Succesfully'),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  text: 'Submit'),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ));
  }
}
