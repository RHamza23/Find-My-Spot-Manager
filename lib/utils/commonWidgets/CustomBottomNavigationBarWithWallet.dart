import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inparkmanager/views/categories/categories.dart';

import '../../views/wallet/wallet.dart';


Widget CustomNavigationBar1() {
  return BottomAppBar(
    color: Colors.transparent,
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
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(wallet());
              },
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
