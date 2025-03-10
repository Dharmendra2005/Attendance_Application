import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'selfie_capture_screen.dart'; 

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

    String username = scannedData; 

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

