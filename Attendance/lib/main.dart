
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:classlytic_app/services/camera_service.dart';
import 'package:classlytic_app/services/AttendanceStatus.dart';
import 'package:classlytic_app/services/GenerateQueryPage.dart';


import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
      final passwordRegex =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
      if (emailRegex.hasMatch(_email) && passwordRegex.hasMatch(_password)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password format!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text("LOGIN", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Emailid',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid Gmail address';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          final passwordRegex =
                              RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must have uppercase, lowercase, number & symbol';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('LOGIN'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                        Navigator.push(
                        context,
                         MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                          },
                        style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                         child: Text('SignUp'),
                     ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // ignore: non_constant_identifier_names
  void _SignUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final usernameRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])');
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
      final passwordRegex =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');

      if (emailRegex.hasMatch(_email) &&
          usernameRegex.hasMatch(_username) &&
          passwordRegex.hasMatch(_password)) {
        // ignore: avoid_print
        print("✅ Signup Successful! Navigating to MainPage...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid username, email, or password format!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                  child: _selectedImage == null
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                SizedBox(height: 10),
                
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.upload),
                  label: Text("Upload Photo"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),

                SizedBox(height: 15),
                Text("SIGNUP",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          final usernameRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])');
                          if (!usernameRegex.hasMatch(value)) {
                            return 'Enter a valid Username';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value!,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'EmailID',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid Gmail address';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          final passwordRegex = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must have uppercase, lowercase, number & symbol';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: _SignUp,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('SIGNIN'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Main Page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CameraService _cameraService = CameraService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('CLASSLYTIC'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'STUDENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
             leading: Icon(Icons.qr_code_2_outlined),
             title: Text('Generate Queries'),
             onTap: () {
            Navigator.push(
             context,
            MaterialPageRoute(builder: (context) => GenerateQueryPage()),
           );
          },
          ),
            ListTile(
              leading: Icon(Icons.analytics_outlined),
              title: Text('Attendance Status'),
              onTap: () {
              Navigator.push(
              context,
             MaterialPageRoute(builder: (context) => AttendanceStatusPage()),
              );
            },
            ),
            ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Log Out'),
            onTap: () {
            _confirmLogout(context); // Call the logout confirmation function
            },
           ),
          ],
        ),
      ),
    body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Open Camera to Scan the Scanner'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _cameraService.openCamera(); // Call the function when button is pressed
              },
              child: Text('OPEN'),
            ),
          ],
        ),
      ),
    );
  }
}

void _confirmLogout(BuildContext context) {
   showDialog(
        context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Log Out"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
              );
            },
            child: Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
