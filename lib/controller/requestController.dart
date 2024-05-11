import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inparkmanager/controller/sighnUpController.dart';
import 'package:inparkmanager/model/requestsVehicleModel.dart';

import '../constants/colors.dart';


class requestController extends GetxController {
  static requestController get instance => Get.find();

  //variables
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<requestVehicleModel>> getRequests() async {
    final snapshot = await _firebaseFirestore
        .collection('Parking Manager')
        .doc(signUpController().getCurrentUserUid())
        .collection('Approve secondary Requests')
        .orderBy('Time', descending: true)
        .get();
    final userdata =
    snapshot.docs.map((e) => requestVehicleModel.fromSnapshot(e)).toList();
    return userdata;
  }

  void updateStatus(String documentID, String newStatus) {
    final documentReference = _firebaseFirestore
        .collection("Parking Manager")
        .doc(signUpController().getCurrentUserUid())
        .collection("Approve secondary Requests")
        .doc(documentID);

    documentReference.update({'Status': newStatus})
        .then((value) => {
          Get.snackbar(newStatus, "Request Has been $newStatus",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: PrimaryColor,
    colorText: Colors.black)})
        .catchError((error) => {Get.snackbar(error, "Something went wrong. Try Again",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: PrimaryColor,
    colorText: Colors.black)});
  }


}
