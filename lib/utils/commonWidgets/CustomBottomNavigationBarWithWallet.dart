import 'package:FindMySpot/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:FindMySpot/views/categories/categories.dart';

import '../../views/wallet/wallet.dart';


Widget CustomNavigationBar1(bool? isSettingScreen) {
  return BottomAppBar(
    color: isSettingScreen != null && isSettingScreen ? PrimaryColor :  Colors.transparent,
    elevation: 0,
    notchMargin: 0.05,
    clipBehavior: Clip.antiAlias,
    child: Container(
      color: Colors.transparent,
      height: kBottomNavigationBarHeight * 0.98,
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Get.to(categories());
              },
              icon: const Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(wallet());
              },
              icon: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
