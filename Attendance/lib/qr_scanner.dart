import 'package:flutter/material.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Text(
          'QR Scanning functionality coming soon!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
