import 'package:flutter/material.dart';

class AttendanceStatusPage extends StatelessWidget {
  final List<Map<String, String>> attendanceRecords = [
    {'date': '2025-03-01', 'status': 'Present'},
    {'date': '2025-03-02', 'status': 'Absent'},
    {'date': '2025-03-03', 'status': 'Present'},
    {'date': '2025-03-04', 'status': 'Late'},
  ];

 AttendanceStatusPage({super.key});

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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'attendance_provider.dart';

// class AttendanceStatusPage extends StatelessWidget {
//   const AttendanceStatusPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AttendanceProvider>(
//       builder: (context, attendanceProvider, child) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Attendance Status')),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Student: ${attendanceProvider.username}',
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Attendance Percentage: ${attendanceProvider.attendancePercentage.toStringAsFixed(1)}%',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: attendanceProvider.attendanceRecords.isEmpty
//                       ? const Center(child: Text("No attendance records available"))
//                       : ListView.builder(
//                           itemCount: attendanceProvider.attendanceRecords.length,
//                           itemBuilder: (context, index) {
//                             final record = attendanceProvider.attendanceRecords[index];
//                             return Card(
//                               child: ListTile(
//                                 leading: const Icon(Icons.check_circle, color: Colors.green),
//                                 title: Text(record['date']),
//                                 subtitle: Text('Status: ${record['status']}'),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

