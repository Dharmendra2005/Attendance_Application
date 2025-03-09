import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  String _username = "Unknown";
  final List<Map<String, dynamic>> _attendanceRecords = [];

  String get username => _username;
  List<Map<String, dynamic>> get attendanceRecords => _attendanceRecords;

  // Calculate attendance percentage
  double get attendancePercentage {
    if (_attendanceRecords.isEmpty) return 0.0;
    int presentCount =
        _attendanceRecords.where((record) => record['status'] == 'Present').length;
    return (presentCount / _attendanceRecords.length) * 100;
  }

  void markAttendance(String username) {
    _username = username;
    _attendanceRecords.add({
      'date': DateTime.now().toString().substring(0, 10), // YYYY-MM-DD
      'status': 'Present',
    });
    notifyListeners();
  }
}
