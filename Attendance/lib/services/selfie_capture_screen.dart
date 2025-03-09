// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:provider/provider.dart';
// import 'attendance_provider.dart';

// class SelfieCaptureScreen extends StatefulWidget {
//   final String username;

//   const SelfieCaptureScreen({super.key, required this.username});

//   @override
//   _SelfieCaptureScreenState createState() => _SelfieCaptureScreenState();
// }

// class _SelfieCaptureScreenState extends State<SelfieCaptureScreen> {
//   CameraController? _cameraController;
//   List<CameraDescription>? cameras;
//   bool _isProcessing = false; // For loading indicator

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       final frontCamera = cameras!.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//       );

//       _cameraController = CameraController(frontCamera, ResolutionPreset.high);
//       await _cameraController!.initialize();
//       if (mounted) setState(() {});
//     } catch (e) {
//       print("❌ Error initializing camera: $e");
//     }
//   }

//   Future<void> _captureSelfie() async {
//     if (_cameraController == null || !_cameraController!.value.isInitialized) {
//       _showDialog("❌ Error", "Camera not initialized.");
//       return;
//     }

//     setState(() => _isProcessing = true);

//     try {
//       final XFile image = await _cameraController!.takePicture();
//       print("✅ Selfie captured: ${image.path}");
      
//       bool isFaceMatched = await _verifyFace(image.path);
//       _showAttendanceDialog(isFaceMatched);
//     } catch (e) {
//       print("❌ Error capturing selfie: $e");
//       _showDialog("❌ Error", "Failed to capture selfie.");
//     }
    
//     setState(() => _isProcessing = false);
//   }

//   Future<bool> _verifyFace(String imagePath) async {
//     await Future.delayed(const Duration(seconds: 2)); // Simulate AI processing
//     return DateTime.now().second % 2 == 0; // Dummy AI check (replace with real logic)
//   }

//   void _showAttendanceDialog(bool isMatched) {
//     if (isMatched) {
//       Provider.of<AttendanceProvider>(context, listen: false).markAttendance(widget.username);
//       _showDialog("✅ Attendance Marked", "Your attendance has been recorded successfully.");
//     } else {
//       _showDialog("❌ Face Not Matched", "Your face does not match. Please try again.");
//     }
//   }

//   void _showDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Capture Selfie")),
//       body: Column(
//         children: [
//           Expanded(
//             child: _cameraController == null || !_cameraController!.value.isInitialized
//                 ? const Center(child: CircularProgressIndicator())
//                 : CameraPreview(_cameraController!),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: _isProcessing ? null : _captureSelfie,
//               child: _isProcessing
//                   ? const SizedBox(
//                       height: 24,
//                       width: 24,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                   : const Text("Capture Selfie"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'attendance_provider.dart';
import 'dart:io';

class SelfieCaptureScreen extends StatefulWidget {
  final String username;

  const SelfieCaptureScreen({super.key, required this.username});

  @override
  _SelfieCaptureScreenState createState() => _SelfieCaptureScreenState();
}

class _SelfieCaptureScreenState extends State<SelfieCaptureScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isProcessing = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      final frontCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(frontCamera, ResolutionPreset.high);
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      print("❌ Error initializing camera: $e");
      _showDialog("Camera Error", "Failed to initialize camera.");
    }
  }

  Future<void> _captureSelfie() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _showDialog("❌ Error", "Camera not initialized.");
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final XFile image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = image;
      });

      // Stop the camera after capturing the selfie
      await _cameraController?.dispose();
      _cameraController = null;

      bool isFaceMatched = await _verifyFace(image.path);
      _showAttendanceDialog(isFaceMatched);
    } catch (e) {
      print("❌ Error capturing selfie: $e");
      _showDialog("❌ Error", "Failed to capture selfie.");
    }

    setState(() => _isProcessing = false);
  }

  Future<bool> _verifyFace(String imagePath) async {
    await Future.delayed(const Duration(seconds: 2));
    return DateTime.now().second % 2 == 0;
  }

  void _showAttendanceDialog(bool isMatched) {
    if (isMatched) {
      Provider.of<AttendanceProvider>(context, listen: false).markAttendance(widget.username);
      _showDialog("✅ Attendance Marked", "Your attendance has been recorded successfully.");
    } else {
      _showDialog("❌ Face Not Matched", "Your face does not match. Please try again.");
    }
  }

  void _showDialog(String title, String message) {
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _retakeSelfie() {
    setState(() {
      _capturedImage = null;
      _initializeCamera(); // Restart the camera
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Selfie")),
      body: Column(
        children: [
          Expanded(
            child: _capturedImage == null
                ? (_cameraController == null || !_cameraController!.value.isInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : CameraPreview(_cameraController!))
                : Image.file(File(_capturedImage!.path)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _isProcessing ? null : _captureSelfie,
                  child: _isProcessing
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Capture Selfie"),
                ),
                if (_capturedImage != null) // Show "Retake Selfie" button
                  TextButton(
                    onPressed: _retakeSelfie,
                    child: const Text("Retake Selfie"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
