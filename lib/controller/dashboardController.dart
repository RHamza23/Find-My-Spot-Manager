import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:FindMySpot/controller/sighnUpController.dart';
import 'package:FindMySpot/controller/updateFeeController.dart';
import 'package:FindMySpot/model/orderScannerModel.dart';

import '../constants/colors.dart';
import '../model/updateFeeModel.dart';
import '../views/Dashboard/dashboard.dart';
import '../views/categories/categories.dart';

class dashboardController extends GetxController {
  static dashboardController get instance => Get.find();
  final updateFeeController _updateFeeController = Get.put(updateFeeController());

  //variables
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // TextField Controllers to get data from textfields
  final phoneNoController = TextEditingController();
  final shipAddressController = TextEditingController();
  final implementedLocationController = TextEditingController();
  final paymentMethodController = TextEditingController();

  final ScannerIdController = TextEditingController();

  //call the function from design and it will do the rest
  final _firebaseFirestore = FirebaseFirestore.instance;

  // Reactive variable to control refresh state
  var refreshState = false.obs;

  // Method to toggle the refresh state
  void toggleRefreshState() {
    refreshState.toggle();
  }


  Future<void> OrderScanner(orderScannerModel order) async {
    await _firebaseFirestore
        .collection("Admin")
        .doc("Scanner Order")
        .collection(signUpController().getCurrentUserUid())
        .doc(order.scannerId)
        .set(order.toJason())
        .whenComplete(() {
      Get.snackbar("Success",
          "Your Order has been confirmed\n You will get Email of Scanner ID",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    });
  }

  Future<bool> checkScannerExists() async {
    // Check if vehicle number already exists in Firestore database
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Admin')
        .doc("Scanner Order")
        .collection(signUpController().getCurrentUserUid())
        .where('OrderStatus', isEqualTo: "Order Confirmed")
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<bool> checkScannerExistInManagerAccount() async {
    // Check if vehicle number already exists in Firestore database
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Parking Manager')
        .doc(signUpController().getCurrentUserUid())
        .collection('Scanners')
        .where('OrderStatus', isEqualTo: "Order Confirmed")
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> addScanner(String scannerId) async {
    updateFeeModel fee = updateFeeModel(bike: "0", car: "0");

    final CollectionReference scannerRef = FirebaseFirestore.instance
        .collection('Admin')
        .doc("Scanner Order")
        .collection(signUpController().getCurrentUserUid().toString());
    final DocumentSnapshot cardSnapshot = await scannerRef.doc(scannerId).get();

    if (cardSnapshot.exists) {
      final Map<String, dynamic>? data =
          cardSnapshot.data() as Map<String, dynamic>?;

      if (data?['ScannerId'] == scannerId) {
        final DocumentReference cardsRef = FirebaseFirestore.instance
            .collection('Parking Manager')
            .doc(signUpController().getCurrentUserUid().toString())
            .collection("Scanners")
            .doc(scannerId);

        await cardsRef.set(data!).whenComplete(() => {
              Get.snackbar("Success",
                  "Your Scanner has been successfully added to your account",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: PrimaryColor,
                  colorText: Colors.black),
                  _updateFeeController.updateFee(fee),
                  Get.to(categories()),
        }); // use ! to assert that data is not null
      } else {
        Get.snackbar("Error", "This Scanner does not exist",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black);
      }
    } else {
      Get.snackbar("Error", "Wrong Scanner Id",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    }
    // wallet balance is also creating when user is adding its scanner
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid())
        .collection("Wallet")
        .doc("Balance");
      await userDoc.set({'balance': 0});
  }


  Future<void> deductScannerFee(orderScannerModel order) async {
    double scannerOrderingFee = 600;
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid())
        .collection("Wallet")
        .doc("Balance");
    final DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final Map<String, dynamic> userData =
      userSnapshot.data() as Map<String, dynamic>;
      final double currentBalance = (userData['balance'] ?? 0).toDouble();
      if (currentBalance > 600) {
        final double newBalance = currentBalance - scannerOrderingFee;
        await userDoc.update({'balance': newBalance});
        await OrderScanner(order);
      } else {
        await userDoc.set({'balance': 0});
        Get.snackbar("Error", "You don't have enough balance",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black);

        return;
      }
    } else {
      // User does not exist, create new document with default balance value of 0
      await userDoc.set({'balance': 0});
    }
  }
}
