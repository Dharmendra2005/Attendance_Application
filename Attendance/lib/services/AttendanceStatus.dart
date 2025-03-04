import 'package:flutter/material.dart';

class AttendanceStatusPage extends StatelessWidget {
  final List<Map<String, String>> attendanceRecords = [
    {'date': '2025-03-01', 'status': 'Present'},
    {'date': '2025-03-02', 'status': 'Absent'},
    {'date': '2025-03-03', 'status': 'Present'},
    {'date': '2025-03-04', 'status': 'Late'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student: John Doe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        attendanceRecords[index]['status'] == 'Present'
                            ? Icons.check_circle
                            : attendanceRecords[index]['status'] == 'Absent'
                                ? Icons.cancel
                                : Icons.error_outline,
                        color: attendanceRecords[index]['status'] == 'Present'
                            ? Colors.green
                            : attendanceRecords[index]['status'] == 'Absent'
                                ? Colors.red
                                : Colors.orange,
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
