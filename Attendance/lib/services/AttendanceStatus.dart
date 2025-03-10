
import 'package:flutter/material.dart';

class AttendanceStatusPage extends StatelessWidget {
  final List<Map<String, String>> attendanceRecords = [
    {'date': '2025-03-01', 'status': 'Present'},
    {'date': '2025-03-02', 'status': 'Absent'},
    {'date': '2025-03-03', 'status': 'Present'},
    {'date': '2025-03-04', 'status': 'Absent'},
  ];

  AttendanceStatusPage({super.key});

  double calculateAttendancePercentage() {
    int totalDays = attendanceRecords.length;
    int presentDays =
        attendanceRecords.where((record) => record['status'] == 'Present').length;

    return (totalDays == 0) ? 0 : (presentDays / totalDays) * 100;
  }

  @override
  Widget build(BuildContext context) {
    double attendancePercentage = calculateAttendancePercentage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student: Dharmendra Gora',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Attendance Percentage: ${attendancePercentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        attendanceRecords[index]['status'] == 'Present'
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: attendanceRecords[index]['status'] == 'Present'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(attendanceRecords[index]['date']!),
                      subtitle: Text('Status: ${attendanceRecords[index]['status']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}