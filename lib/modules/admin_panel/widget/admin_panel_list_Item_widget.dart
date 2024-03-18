import 'package:flutter/material.dart';

class AdminPanelListItem extends StatelessWidget {
  const AdminPanelListItem({
    Key? key,
    required this.name,
    required this.location,
    required this.dateOfRegister,
    required this.imageUrl,
    this.onTap,
    required this.itrmCount,
  }) : super(key: key);

  final String name;
  final String location;
  final String dateOfRegister;
  final String imageUrl;
  final int itrmCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: itrmCount,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 60,
                      width: 60,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Flexible(
                                child: Text(
                                  'Name: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Flexible(
                                child: Text(
                                  'Location: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Flexible(
                                child: Text(
                                  'Date of Register: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  dateOfRegister,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
        });
  }
}
