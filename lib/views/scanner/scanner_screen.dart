import 'package:FindMySpot/constants/image_strings.dart';
import 'package:FindMySpot/controller/scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  initState() {
    ScannerController.startNFCService();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Card Scanner',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                SplashImage,
                width: 200,
                height: 200,
              ),
              Text('Scan your card', style: TextStyle(color:Colors.black, fontSize: 30),)
                // ElevatedButton(
                //   onPressed: () => {},
                //   child: const Text(
                //     'Start Scanning',
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
  }
}