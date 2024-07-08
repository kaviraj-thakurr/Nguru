import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height *0.6,
      width: double.infinity,
      child: Column(
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 30,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Text("Attendence", style: TextStyle(fontSize: 24)),
            ],
          ),
          _buildMonthSelector(),
           SizedBox(height: 20,),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerVisible: false,
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          const SizedBox(height: 10),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(month),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      months.indexOf(month) + 1,
                    );
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      children: [
        _buildLegendItem("Present", Colors.green),
        _buildLegendItem("Absent", Colors.red),
        _buildLegendItem("Half Day", Colors.blue),
        _buildLegendItem("Late", Colors.purple),
        _buildLegendItem("Leave", Colors.orange),
        _buildLegendItem("Holiday", Colors.grey),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 8),
        const SizedBox(width: 3),
        Text(
          text,
          style:const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
