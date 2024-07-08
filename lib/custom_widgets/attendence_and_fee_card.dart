import 'package:flutter/material.dart';


Widget attendenceAndFeeCard(BuildContext context,
    {String? headerText, String? mainText, String? footerText}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.13,
    width: MediaQuery.of(context).size.width * 0.34,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
          20.0), // Half of the width/height for a perfect circle
      border: Border.all(
        color: const Color.fromARGB(255, 240, 240, 240),
        width: 2.0,
      ),
    ),
    child: Padding(
      padding:const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             headerText  != null
                  ? Text(
                      headerText ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    )
                  : const SizedBox(),
              Text(
                mainText ?? '__',
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Text(
                      footerText ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  
            ],
          ),
        const  Icon(
            Icons.circle,
            color: Colors.green,
            size: 10,
          ),
        ],
      ),
    ),
  );
}
