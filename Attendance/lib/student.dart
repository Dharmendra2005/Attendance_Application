// student.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentSignUpPage extends StatefulWidget {
  const StudentSignUpPage({super.key});

  @override
  _StudentSignUpPageState createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _image;
  String _uploadButtonText = "Upload a photo";

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadButtonText = "Photo Uploaded";
      });
    }
  }

  void _signUp() {
    if (_usernameController.text.isEmpty) {
      _showErrorDialog('Please fill in the username.');
    } else if (_emailController.text.isEmpty) {
      _showErrorDialog('Please fill in the email.');
    } else if (_passwordController.text.isEmpty) {
      _showErrorDialog('Please fill in the password.');
    } else if (_image == null) {
      _showErrorDialog('Please upload a photo.');
    } else {
      // If all fields are filled, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentHomePage()),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xFF2ECC71),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildTextField('Username', _usernameController),
                    SizedBox(height: 20),
                    _buildTextField('Email', _emailController),
                    SizedBox(height: 20),
                    _buildTextField('Password', _passwordController, obscureText: true),
                    SizedBox(height: 20),
                    _buildUploadButton(),
                    SizedBox(height: 30),
                    _buildSignUpButton(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            _uploadButtonText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: _signUp, // Calls the _signUp method when tapped
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF2ECC71),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}


class StudentLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField('Username/Email', _emailController),
                  SizedBox(height: 20),
                  _buildTextField('Password', _passwordController, obscureText: true),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton('sign up', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentSignUpPage()),
                        );
                      }),
                      SizedBox(width: 20),
                      _buildButton('sign in', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentHomePage()),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            color: Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF2ECC71),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class StudentHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Open Camera to scan scanner",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Open camera logic here
                  },
                  child: Text("Open"),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.green,
      ),
    );
  }
}
