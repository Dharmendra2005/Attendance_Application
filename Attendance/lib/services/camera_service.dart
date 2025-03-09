// import 'package:image_picker/image_picker.dart';
// // import 'dart:io';

// class CameraService {
//   final ImagePicker _picker = ImagePicker();

//   Future<XFile?> openCamera() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);

//     if (image != null) {
//       print('Image Path: ${image.path}');
//     } else {
//       print('No image captured.');
//     }

//     return image; // Return the captured image
//   }
// }
// import 'package:image_picker/image_picker.dart';

// class CameraService {
//   final ImagePicker _picker = ImagePicker();

//   Future<XFile?> openCamera() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         preferredCameraDevice: CameraDevice.rear, // Opens the rear camera by default
//       );

//       if (image != null) {
//         print('Image Path: ${image.path}');
//       } else {
//         print('No image captured.');
//       }

//       return image;
//     } catch (e) {
//       print('Error opening camera: $e');
//       return null;
//     }
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';

// class QRScannerPage extends StatefulWidget {
//   const QRScannerPage({super.key});

//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }

// class _QRScannerPageState extends State<QRScannerPage> {
//   bool isProcessing = false;
//   MobileScannerController cameraController = MobileScannerController();

//   @override
//   void dispose() {
//     cameraController.dispose();
//     super.dispose();
//   }

//   void _handleQRCodeScan(String scannedData) async {
//     print("🔍 Scanned Data: $scannedData"); // Debugging

//     if (isProcessing) return;
//     setState(() {
//       isProcessing = true;
//     });

//     String url = scannedData.startsWith("http") ? scannedData : "https://$scannedData";
//     Uri? uri = Uri.tryParse(url);

//     if (uri != null && await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       _showErrorSnackBar("Invalid or unopenable QR Code: $scannedData");
//     }

//     await Future.delayed(const Duration(seconds: 2));
//     setState(() {
//       isProcessing = false;
//     });
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("QR Scanner")),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: cameraController,
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
//                 _handleQRCodeScan(barcodes.first.rawValue!);
//               }
//             },
//             errorBuilder: (context, error, child) {
//               return Center(child: Text("❌ Camera Error: ${error.toString()}"));
//             },
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             right: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 cameraController.start();
//               },
//               child: Text("Restart Scanner"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'selfie_capture_screen.dart'; // Import the selfie capture page

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isProcessing = false;
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _handleQRCodeScan(String scannedData) async {
    print("🔍 Scanned Data: $scannedData"); // Debugging

    if (isProcessing) return;
    setState(() {
      isProcessing = true;
    });

    // Extract the scanned QR data as username (Modify as needed)
    String username = scannedData; // Assuming QR contains the username

    // Navigate to SelfieCaptureScreen with the extracted username
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelfieCaptureScreen(username: username),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Scanner")),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _handleQRCodeScan(barcodes.first.rawValue!);
              }
            },
            errorBuilder: (context, error, child) {
              return Center(child: Text("❌ Camera Error: ${error.toString()}"));
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                cameraController.start();
              },
              child: Text("Restart Scanner"),
            ),
          ),
        ],
      ),
    );
  }
}

