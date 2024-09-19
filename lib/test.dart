import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.grey, // Customize the color here
                  thickness: 1.0, // Customize the thickness here
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Please type in your query.',
                  style: TextStyle(
                    color: Colors.grey, // Text color
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey, // Same color as the first divider
                  thickness: 1.0, // Same thickness
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

