import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inparkmanager/controller/sighnUpController.dart';
import 'package:inparkmanager/model/orderScannerModel.dart';

import '../constants/colors.dart';
import '../model/updateFeeModel.dart';
import '../views/categories/categories.dart';

class updateFeeController extends GetxController {
  static updateFeeController get instance => Get.find();

  //call the function from design and it will do the rest
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateFee(updateFeeModel fee) async {
    await _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid())
        .collection("VehicleFee").doc("UpdateFee")
        .set(fee.toJason())
        .whenComplete(() {
      Get.snackbar("Success", "Kindly Update your Fee in Account Setting",
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

  Future<updateFeeModel> getFeeDetails() async {
    final snapshot = await _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid().toString())
        .collection("VehicleFee").doc("UpdateFee")
        .get();
    final userdata = updateFeeModel.fromSnapshot(snapshot);
    return userdata;
    // final userdata =
    //     snapshot.docs.map((e) => updateFeeModel.fromSnapshot(e)).single;
    // return userdata;
  }

  Future<void> updateFeeRecord(updateFeeModel fee) async {
    // var documentID;
    // var collection = FirebaseFirestore.instance
    //     .collection('Parking Manager')
    //     .doc(signUpController().getCurrentUserUid().toString())
    //     .collection("VehicleFee");
    // var querySnapshots = await collection.get();
    // for (var snapshot in querySnapshots.docs) {
    //   documentID = snapshot.id; // <-- Document ID
    // }

    await _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid().toString())
        .collection("VehicleFee"). doc("UpdateFee")
        .update(fee.toJason())
        .whenComplete(() => {
              Get.snackbar("Success", "Your Fee has been updated",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: PrimaryColor,
                  colorText: Colors.black)
            });
  }
}
