import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/my_assets.dart';
import 'package:nguru/utils/my_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 20,
                left: 150,
                child: InkWell(
                  onTap: () {log("button clicked");},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: MyColors.buttonColors,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 7), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 65.0,
                        width: 65.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          bottom: 6,
                          child: SvgPicture.asset(
                            MyAssets.homeIcon,
                            width: 45,
                            height: 45,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Container(
            color:const Color.fromARGB(255, 255, 255, 255),
            height: MediaQuery.of(context).size.height * 1,
            width: double.infinity,
            child: Padding(
              padding:const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20.0), // Half of the width/height for a perfect circle
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 240, 240),
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                         //   mainAxisSize: MainAxisSize.min,
                         mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 45.0,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/150'), // Replace with your image URL
                              ),
                            const  SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Anshul Goswami',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined))
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'XI B',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '1237/AA/2023B',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20.0), // Half of the width/height for a perfect circle
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 240, 240),
                            width: 2.0,
                          ),
                        ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '53%',
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Attendence',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                              Container(
                              decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20.0), // Half of the width/height for a perfect circle
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 240, 240),
                            width: 2.0,
                          ),
                        ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                         Text(
                                        'Paid 23k',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey,
                                        //  fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '23k',
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Advance 23k',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                       
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
