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
      bottomNavigationBar: CustomNavigationBar1(null),
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(30, 59, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                  Get.to(const manageCars());
                  },
                  child: Image.asset(carButton, height: 170,),
                ),
                const SizedBox(height: 10,),

                InkWell(
                  onTap: () {
                    Get.to( manageBikes());
                  },
                  child: Image.asset(bikeButton, height: 190,),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerScreen())),
                  child: Image.asset(nfcButton, height: 190,),
                ),
              ],
            ),
          ),
          

        ],
      ),
    );
  }
}
