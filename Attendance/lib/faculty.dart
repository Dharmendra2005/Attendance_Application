import 'package:flutter/material.dart';

class FacultyPage extends StatelessWidget {
  const FacultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Faculty Page'),
      ),
      body: Center(
        child: Text(
          'Faculty Features Coming Soon!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
