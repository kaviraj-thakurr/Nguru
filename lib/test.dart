import 'package:flutter/material.dart';


class RadioButtonExample extends StatefulWidget {
  @override
  _RadioButtonExampleState createState() => _RadioButtonExampleState();
}

class _RadioButtonExampleState extends State<RadioButtonExample> {
  int? _selectedValue; // To store the selected radio button value
  String _displayText = "Please select an option"; // Initial display text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio Button Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(5, (int index) {
              return Row(
                children: [
                  Radio<int>(
                   activeColor: Colors.green,
                    
                    value: index,
                    groupValue: _selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedValue = value;
                        _displayText = "You selected option ${_selectedValue! + 1}";
                      });
                    },
                  ),
                  Text("Option ${index + 1}"),
                ],
              );
            }),
          ),
          SizedBox(height: 20),
          Text(
            _displayText,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
