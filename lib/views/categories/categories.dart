import 'package:FindMySpot/views/scanner/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FindMySpot/constants/colors.dart';
import 'package:FindMySpot/constants/text_strings.dart';

import '../../constants/image_strings.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import 'manageBikes.dart';
import 'manageCars.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar1(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton:
      FloatingActionButtonWithNotched(),
      backgroundColor: PrimaryColor,
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                categoriesTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontFamily: 'Lobster'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Image.asset(
                whiteBackground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                  Get.to(const manageCars());
                  },
                  child: Image.asset(carButton),
                ),
                InkWell(
                  onTap: () {
                    Get.to( manageBikes());
                  },
                  child: Image.asset(bikeButton),
                ),
                Container(
            margin: const EdgeInsets.only(top: 25),
            child: MaterialButton(
            color: PrimaryColor,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerScreen())), 
            child: const Text('NFC Scanning mode', style: TextStyle(color: Colors.white),),),
          )
              ],
            ),
          ),
          

        ],
      ),
    );
  }
}
