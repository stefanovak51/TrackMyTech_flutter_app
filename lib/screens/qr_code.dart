import 'package:flutter/material.dart';
import 'package:trackmytech/screens/qr_scanner.dart';

import '../colors.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  bool isFavorited = false;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: AppColors.main,
        toolbarHeight: 100.0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo.png', scale: 1.1,
        ),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/QR.png',
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScannerScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(220, 50),
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Скенирај QR код',
                    style: TextStyle(
                      color: AppColors.main,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

