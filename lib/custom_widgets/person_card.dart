import 'package:flutter/material.dart';
import 'package:nguru/utils/my_colors.dart';

Widget personInfoCard(BuildContext context){
  return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.59,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    12.0), // Half of the width/height for a perfect circle
                border: Border.all(
                  color: MyColors.borderColor,
                  width: 1.0,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // Replace with your image URL
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Anshul Goswami',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: MyColors.boldTextColor
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined)
                        // IconButton(
                        //     onPressed: () {},
                        //     icon:  Icon(
                        //         Icons.keyboard_arrow_down_outlined))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'XI B',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: MyColors.fadedTextColor,
                          ),
                        ),
                        Text(
                          '1237/AA/2023B',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:MyColors.fadedTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}