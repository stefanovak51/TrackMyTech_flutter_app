import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:trackmytech/colors.dart';
import 'device_info.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.main,
        toolbarHeight: 100.0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo.png', scale: 1.1,
        ),),
      body: MobileScanner(
        controller: MobileScannerController(),
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressScreen(qrData: code),
                ),
              );
              break; // Only navigate once
            }
          }
        },
      ),
    );
  }
}
