import 'package:flutter/material.dart';


class ReportCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Report Card'),
      ),
      body: ReportCard(
        studentName: 'John Doe',
        studentClass: 'Grade 10',
        rollNumber: '23',
        subjects: const [
          {'name': 'Mathematics', 'grade': 'A'},
          {'name': 'Science', 'grade': 'B+'},
          {'name': 'English', 'grade': 'A-'},
          {'name': 'History', 'grade': 'B'},
          {'name': 'Geography', 'grade': 'B+'},
        ],
        finalGrade: 'B+',
        remarks: 'Good performance overall, but needs improvement in Science and History.',
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String studentName;
  final String studentClass;
  final String rollNumber;
  final List<Map<String, String>> subjects;
  final String finalGrade;
  final String remarks;

  ReportCard({
    required this.studentName,
    required this.studentClass,
    required this.rollNumber,
    required this.subjects,
    required this.finalGrade,
    required this.remarks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student Info Section
          Text(
            'Student Name: $studentName',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Class: $studentClass'),
          Text('Roll Number: $rollNumber'),
          const SizedBox(height: 16),

          // Subject Grades Section
          const Text(
            'Subjects & Grades:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...subjects.map((subject) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(subject['name']!),
                  Text(subject['grade']!),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 16),

          // Final Grade Section
          Text(
            'Final Grade: $finalGrade',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Remarks Section
          const Text(
            'Remarks:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(remarks),
        ],
      ),
    );
  }
}
