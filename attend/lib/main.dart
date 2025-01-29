import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xCCC8C6C6), // Dark theme background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login Button
            TextButton(
  onPressed: () {
    // Handle login functionality
  },
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Text(
      "Login",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  ),
),
            SizedBox(height: 30), // Spacing

            // Student Button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentScreen()));
              },
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Student", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing

            // Faculty Button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyScreen()));
              },
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Faculty", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy screens for Student and Faculty
class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Dashboard")),
      body: Center(child: Text("Welcome Student!", style: TextStyle(fontSize: 20))),
    );
  }
}

class FacultyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faculty Dashboard")),
      body: Center(child: Text("Welcome Faculty!", style: TextStyle(fontSize: 20))),
    );
  }
}
